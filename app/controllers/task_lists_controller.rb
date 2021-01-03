class TaskListsController < ApplicationController
  include ApplicationHelper
  before_action :set_task_list, only: [:show, :edit, :update, :destroy, :archive, :task_items]

  # GET /task_lists
  # GET /task_lists.json
  def index
    @task_lists = TaskList.all
  end

  # GET /task_lists/1
  # GET /task_lists/1.json
  def show
  end

  # GET /task_lists/new
  def new
    @task_list = TaskList.new

    @html_content = render_to_string :partial => 'task_lists/form', :locals => { task_list: @task_list, button_text: "Add" }
    
    render :json => { :html_content => @html_content, title: "New Task List" }
  end

  # GET /task_lists/1/edit
  def edit

    @html_content = render_to_string :partial => 'task_lists/form', :locals => { task_list: @task_list, button_text: "Edit" }
    
    render :json => { :html_content => @html_content, title: "Edit Task List" }
  end

  # POST /task_lists
  # POST /task_lists.json
  def create
    @task_list = TaskList.new(task_list_params)

    respond_to do |format|
      if @task_list.save
        @task_lists = TaskList.all
        format.html { render :index, notice: 'Task list was successfully created.' }
        format.json { render :show, status: :created, location: @task_list }
      else
        format.html { render :new }
        format.json { render json: @task_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_lists/1
  # PATCH/PUT /task_lists/1.json
  def update
    respond_to do |format|
      if @task_list.update(task_list_params)
        @task_lists = TaskList.all
        format.html { render :index, notice: 'Task list was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_list }
      else
        format.html { render :edit }
        format.json { render json: @task_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_lists/1
  # DELETE /task_lists/1.json
  def destroy
    @task_list.destroy
    respond_to do |format|
      format.html { redirect_to task_lists_url, notice: 'Task list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def archive
    archive_val = @task_list.archive == true ? false : true

    archive_message = archive_val == true ? "#{@task_list.name} has been archived." : "#{@task_list.name} has been removed from the archive."
    
    respond_to do |format|
      if @task_list.update(archive: archive_val)        
        format.html { redirect_to task_lists_url, notice: archive_message }
      else
        format.html { redirect_to task_lists_url, notice: 'Error archiving.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_list
      @task_list = TaskList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_list_params
      params.require(:task_list).permit(:name, :archive)
    end
end
