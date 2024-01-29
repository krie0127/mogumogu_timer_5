class StopwatchesController < ApplicationController
  def create
    hours = params[:hours]
    minutes = params[:minutes]
    seconds = params[:seconds]

    @time = Stopwatch.new(stopwatch_params)

    if @time.save
      render json: { status: 'success', message: 'Time saved successfully' }
    else
      render json: { status: 'error', message: 'Failed to save time' }
    end
  end
    
  def index
    @times = Stopwatch.all
      respond_to do |format|
      format.html
      format.json { render json: @times }
    end
  end

  def update
    @time = Stopwatch.find(params[:id]) # 特定のタイムレコードを取得
    if @time.update(stopwatch_params)
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
    params.require(:stopwatch).permit(:duration, :start_time, :end_time)
  end
end
