class SelectedTasksController < ApplicationController
  before_action :set_selected_task, only: [:show, :edit, :update, :destroy]

  # GET /selected_tasks
  # GET /selected_tasks.json
  def index
    @selected_tasks = SelectedTask.all
  end

  # GET /selected_tasks/1
  # GET /selected_tasks/1.json
  def show
  end

  # GET /selected_tasks/new
  def new
    @selected_task = SelectedTask.new
  end

  # GET /selected_tasks/1/edit
  def edit
  end

  # POST /selected_tasks
  # POST /selected_tasks.json
  def create
    @selected_task = SelectedTask.new(selected_task_params)

    respond_to do |format|
      if @selected_task.save
        format.html { redirect_to @selected_task, notice: 'Selected task was successfully created.' }
        format.json { render :show, status: :created, location: @selected_task }
      else
        format.html { render :new }
        format.json { render json: @selected_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /selected_tasks/1
  # PATCH/PUT /selected_tasks/1.json
  def update
    respond_to do |format|
      if @selected_task.update(selected_task_params)
        format.html { redirect_to @selected_task, notice: 'Selected task was successfully updated.' }
        format.json { render :show, status: :ok, location: @selected_task }
      else
        format.html { render :edit }
        format.json { render json: @selected_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selected_tasks/1
  # DELETE /selected_tasks/1.json
  def destroy
    @selected_task.destroy
    respond_to do |format|
      format.html { redirect_to selected_tasks_url, notice: 'Selected task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_selected_task
      @selected_task = SelectedTask.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def selected_task_params
      params.require(:selected_task).permit(:instruction_id, :task_item_id, :is_complete, :complete_date)
    end
end
