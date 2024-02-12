class StopwatchesController < ApplicationController
  before_action :set_stopwatch, only: [:update]

  def create
    @stopwatch = current_user.stopwatches.new(stopwatch_params)

    if @stopwatch.save
      render json: { status: 'success', message: 'タイマーを保存しました' }, status: :created
    else
      render json: { status: 'error', message: 'タイマーの保存に失敗しました', errors: @stopwatch.errors.full_messages }, status: :unprocessable_entity
    end
  end
    
  def index
    @stopwatches = Stopwatch.all
    respond_to do |format|
      format.html
      format.json { render json: @stopwatches }
    end
  end

  def update
    if @stopwatch.update(stopwatch_params)
      flash[:notice] = 'タイマーが更新されました'
      redirect_to stopwatches_path, notice: 'Time record was successfully updated.'
    else
      render :edit
    end
  end

  def show
    @meals = current_user.stopwatches.where('DATE(start_time) = ?', Date.today)
    breakfast_result = calculate_total_time(@meals, 'breakfast')
    @breakfast_time = "#{breakfast_result[:minutes]} 分 #{breakfast_result[:seconds]} 秒"
  
    lunch_result = calculate_total_time(@meals, 'lunch')
    @lunch_time = "#{lunch_result[:minutes]} 分 #{lunch_result[:seconds]} 秒"
  
    dinner_result = calculate_total_time(@meals, 'dinner')
    @dinner_time = "#{dinner_result[:minutes]} 分 #{dinner_result[:seconds]} 秒"
  end
  

  def my_page
    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month
    date_range = (start_date..end_date).to_a
    
    # 1ヶ月分の日付でハッシュを0で初期化
    @durations = date_range.each_with_object({}) do |date, hash|
      hash[date.strftime('%Y-%m-%d')] = 0
    end
    
    # Stopwatchのデータでハッシュの値を更新
    Stopwatch.all.each do |stopwatch|
      key = stopwatch.created_at.strftime("%Y-%m-%d")
      if @durations.key?(key)
        duration = (stopwatch.end_time - stopwatch.start_time) / 60.0 # 分単位で計算
        @durations[key] += duration # 同日のデータは累計する
      end
      @formatted_durations = @durations.map { |date, value| [Date.parse(date).strftime('%-d'), value] }.to_h
    end
    @stopwatches = Stopwatch.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
                        .group_by { |stopwatch| stopwatch.created_at.to_date } || {}
  end

  def daily
    @date = Date.parse(params[:date])
    @meals = current_user.stopwatches.where('DATE(created_at) = ?', @date)    
    breakfast_result = calculate_total_time(@meals, 'breakfast')
    @breakfast_time = "#{breakfast_result[:minutes]} 分 #{breakfast_result[:seconds]} 秒"

    lunch_result = calculate_total_time(@meals, 'lunch')
    @lunch_time = "#{lunch_result[:minutes]} 分 #{lunch_result[:seconds]} 秒"
  
    dinner_result = calculate_total_time(@meals, 'dinner')
    @dinner_time = "#{dinner_result[:minutes]} 分 #{dinner_result[:seconds]} 秒"
  end

  private

  def calculate_total_time(stopwatches, meal_type)
    total_seconds = stopwatches.where(meal_type: meal_type).sum do |stopwatch|
      (stopwatch.end_time - stopwatch.start_time).to_i
    end
    minutes = total_seconds / 60
    seconds = total_seconds % 60
    { minutes: minutes, seconds: seconds }
  end
  
  def set_stopwatch
    @stopwatch = Stopwatch.find(params[:id])
  end
  
  def stopwatch_params
    params.require(:stopwatch).permit(:start_time, :end_time, :meal_type)
  end
end