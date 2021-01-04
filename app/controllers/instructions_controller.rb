class InstructionsController < ApplicationController
  before_action :set_instruction, only: [:show, :edit, :update, :destroy]
  before_action :set_patient, only: [:new, :edit]
  # GET /instructions
  # GET /instructions.json
  def index
    @instructions = Instruction.all
  end

  # GET /instructions/1
  # GET /instructions/1.json
  def show
  end

  # GET /instructions/new
  def new
    # get tasks lists to display possible choices of task items to select
    @task_lists = TaskList.where("archive = ? OR archive IS NULL", "false")
    
    @instruction = Instruction.new

    @html_content = render_to_string :partial => 'instructions/form', :locals => { task_lists: @task_lists, instruction: @instruction, patient: @patient, button_text: "Assign" }
    
    # send html to javascript to insert the form html into the modal
    render :json => { :html_content => @html_content, title: "Assign Task List" }
  end

  # GET /instructions/1/edit
  def edit
    # sort tasks by due date
    @selected_tasks = @instruction.selected_tasks

    # more preferable to use active record order, in the future add the due attr to the selected tasks
    @selected_tasks = @selected_tasks.sort_by { |st| st.task_item.due }

    if @selected_tasks.all? { |st| st.is_complete }
      # when viewing tasks from the patient list and all tasks are complete
      @html_content = render_to_string :partial => 'instructions/instructions_complete', :locals => { selected_tasks: @selected_tasks, instruction: @instruction, patient: @patient, button_text: nil }
      
      render :json => { :html_content => @html_content, title: "Congratulations!" }    
    else
      # displaying task items for a patient so that they may interact with them
      @html_content = render_to_string :partial => 'instructions/patient_task_list', :locals => { selected_tasks: @selected_tasks, instruction: @instruction, patient: @patient, button_text: nil }

      title = "Task List for #{@patient.first_name} #{@patient.last_name}"

      render :json => { :html_content => @html_content, title: title }
    end
  end

  # POST /instructions
  # POST /instructions.json
  def create
    @instruction = Instruction.new(instruction_params)

    # build the selected tasks based off of the selected task_items
    # could be done better with nested form attributes
    task_item_ids = params[:selected_tasks].keys

    task_item_ids.size.times { |idx| @instruction.selected_tasks.build(task_item_id: task_item_ids[idx]) }

    # on successful save, return to patients index
    # not currently handling saving errors
    respond_to do |format|
      if @instruction.save
        @patients = Patient.all
        format.html { render "patients/index", notice: 'Instruction was successfully created.' }
      end
    end
  end

  # PATCH/PUT /instructions/1
  # PATCH/PUT /instructions/1.json
  def update
    respond_to do |format|
      if @instruction.update(instruction_params)
        format.html { redirect_to @instruction, notice: 'Instruction was successfully updated.' }
        format.json { render :show, status: :ok, location: @instruction }
      else
        format.html { render :edit }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_selected_task
    # :instruction_id, :task_item_id, :is_complete, :complete_date
    selected_task_id = params[:id]

    @selected_task = SelectedTask.find(selected_task_id)

    @selected_task.update(is_complete: true, complete_date: Time.now)
    
    # check if all task are complete, if so, send back new html
    if @selected_task.instruction.selected_tasks.all? { |st| st.is_complete == true }
      # return new html
      @html_content = render_to_string :partial => 'instructions/instructions_complete', :locals => { button_text: nil }

      render :json => { :html_content => @html_content, title: "Congratulations!" }
    else
      # return the object as json to update the modal
      render :json => { selected_task: @selected_task }
    end
  end

  # DELETE /instructions/1
  # DELETE /instructions/1.json
  def destroy
    @instruction.destroy
    respond_to do |format|
      format.html { redirect_to instructions_url, notice: 'Instruction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instruction
      @instruction = Instruction.find(params[:id])
    end

    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

    # Only allow a list of trusted parameters through.
    def instruction_params
      params.require(:instruction).permit(
        :task_list_id, :patient_id, :start_date,
        selected_tasks_attributes: [:task_item_id, :instruction_id, :is_complete, :complete_date])
    end
end
