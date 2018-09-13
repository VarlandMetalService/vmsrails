class Printing::PrintQueuesController < ApplicationController
  before_action :set_print_queue, only: [:show, :edit, :update, :destroy]

  def index
    @print_queues = Printing::PrintQueue.all
  end

  def show
  end

  def new
    @print_queue = Printing::PrintQueue.new
  end

  def edit
  end

  def create
    @print_queue = Printing::PrintQueue.new(print_queue_params)
    respond_to do |format|
      if @print_queue.save
        format.html { redirect_to printing_print_queues_path, notice: 'Print queue was successfully created.' }
        format.json { redirect_to printing_print_queues_path, status: :created, location: @print_queue }
      else
        format.html { render :new }
        format.json { render json: @print_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @print_queue.update(print_queue_params)
        format.html { redirect_to printing_print_queues_path, notice: 'Print queue was successfully updated.' }
        format.json { redirect_to printing_print_queues_path, status: :ok, location: @print_queue }
      else
        format.html { render :edit }
        format.json { render json: @print_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @print_queue.destroy
    respond_to do |format|
      format.html { redirect_to printing_print_queues_url, notice: 'Print queue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_print_queue
      @print_queue = Printing::PrintQueue.find(params[:id])
    end

    def print_queue_params
      params.require(:printing_print_queue).permit(:printer, :options)
    end
end