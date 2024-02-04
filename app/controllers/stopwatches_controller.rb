class StopwatchesController < ApplicationController
  before_action :set_stopwatch, only: [:update] # 必要に応じて他のアクションを追加

  def create
    @stopwatch = current_user.stopwatches.new(stopwatch_params) 

    if @stopwatch.save
      render json: { status: 'success', message: 'Time saved successfully' }, status: :created
    else
      render json: { status: 'error', message: 'Failed to save time', errors: @stopwatch.errors.full_messages }, status: :unprocessable_entity
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
      redirect_to stopwatches_path, notice: 'Time record was successfully updated.'
    else
      render :edit
    end
  end

  def my_page
    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month
    date_range = (start_date..end_date).to_a
    
    # 1ヶ月分の日付でハッシュを0で初期化
    @durations = date_range.each_with_object({}) do |date, hash|
      hash[date.strftime("%Y-%m-%d")] = 0
    end
    
    # Stopwatchのデータでハッシュの値を更新
    Stopwatch.all.each do |stopwatch|
      key = stopwatch.created_at.strftime("%Y-%m-%d")
      if @durations.key?(key)
        duration = (stopwatch.end_time - stopwatch.start_time) / 60.0 # 分単位で計算
        @durations[key] += duration # 同日のデータは累計する
      end
      @formatted_durations = @durations.map { |date, value| [Date.parse(date).strftime("%-d"), value] }.to_h
    end
  end
  
  private
  
  def set_stopwatch
    @stopwatch = Stopwatch.find(params[:id])
  end
  
  def stopwatch_params
    params.require(:stopwatch).permit(:start_time, :end_time)
  end
end
