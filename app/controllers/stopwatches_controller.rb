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
  
  private
  
  def set_stopwatch
    @stopwatch = Stopwatch.find(params[:id])
  end
  
  def stopwatch_params
    params.require(:stopwatch).permit(:start_time, :end_time)
  end
end
