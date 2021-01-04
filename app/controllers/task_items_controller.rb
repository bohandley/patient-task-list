class TaskItemsController < ApplicationController
  before_action :set_task_item, only: [:show, :edit, :update, :destroy, :archive]
  before_action :set_task_list, only: [:index, :new, :edit]
  # GET /task_items
  # GET /task_items.json
  def index
    @task_items = @task_list.task_items
  end

  # GET /task_items/1
  # GET /task_items/1.json
  def show
  end

  # GET /task_items/new
  def new
    @task_item = @task_list.task_items.build

    @html_content = render_to_string :partial => 'task_items/form', :locals => { task_item: @task_item, task_list: @task_list, button_text: "Add" }
    
    render :json => { :html_content => @html_content, title: "New Task Item" }
  end

  # GET /task_items/1/edit
  def edit

    @html_content = render_to_string :partial => 'task_items/form', :locals => { task_item: @task_item, task_list: @task_list, button_text: "Edit" }
    
    render :json => { :html_content => @html_content, title: "Edit Task Item" }
  end

  # POST /task_items
  # POST /task_items.json
  def create
    @task_item = TaskItem.new(task_item_params)

    respond_to do |format|
      if @task_item.save
        
        @task_list = @task_item.task_list
        @task_items = @task_list.task_items 
        
        format.html { render :index, notice: 'Task item was successfully created.' }
        format.json { render :show, status: :created, location: @task_item }
      else
        format.html { render :new }
        format.json { render json: @task_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_items/1
  # PATCH/PUT /task_items/1.json
  def update
    @task_list = @task_item.task_list

    # redirect to the same task list task items
    url = "/task_lists/#{@task_list.id}/task_items"

    respond_to do |format|
      if @task_item.update(task_item_params)
        format.html { redirect_to url, notice: 'Task item was successfully updated.' }
      end
    end
  end

  # DELETE /task_items/1
  # DELETE /task_items/1.json
  def destroy
    @task_item.destroy
    respond_to do |format|
      format.html { redirect_to task_items_url, notice: 'Task item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def archive
    archive_val = @task_item.archive == true ? false : true

    archive_message = archive_val == true ? "#{@task_item.title} has been archived." : "#{@task_item.title} has been removed from the archive."
    
    respond_to do |format|
      if @task_item.update(archive: archive_val)        
        @task_list = @task_item.task_list
        @task_items = @task_list.task_items

        format.html { render :index, notice: archive_message }
      else
        format.html { redirect_to task_lists_url, notice: 'Error archiving.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_item
      @task_item = TaskItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_item_params
      params.require(:task_item).permit(:title, :body, :due, :task_list_id, :archive)
    end

    def set_task_list
      @task_list = TaskList.find(params[:task_list_id])
    end
end
