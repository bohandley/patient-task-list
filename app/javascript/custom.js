// ids for listeners
// each clcik of and id hits a route and loads html into the modal
const IDS = [
	"#add-task-list",
	"#add-task-item",
	"#add-patient",
	".task-list-edit",
	".task-item-edit",
	".patient-edit",
];

$( document ).on('turbolinks:load', function() {
	// load form html into modal
	IDS.forEach(id => {
		$(id).on("click", function(e){
			loadModalContent(e, this)
		});
	});
		
	// load form html and add special event listeners
	$(".patient-instructions-assign").on("click", function(e){
		loadModalContent(e, this, addAssignTaskListeners)
	});

	$(".patient-instructions-view").on("click", function(e){
		loadModalContent(e, this, addViewTaskListListeners)
	});

});

// general modal functions
function loadModalTitle(title) {
	$('#app-modal-title').html(title);
}

function loadModalBody(body) {
	$('#app-modal-body').html(body);
}

function showModal() {
	$("#app-modal").modal("show");
}

function hideModal() {
	$("#app-modal").modal("hide");
}

function clearModalBody() {
	$('#app-modal-body').html('');
}

// ajax call to the back end
// back end sends html
// for some forms, add listeners after the promise returns
function loadModalContent(e, that, eventListener) {
	e.preventDefault();
		
	// pass these functions in for assign and view task list for patient
	// to add listeners for html insterted into the modal
	var event = eventListener == null ? () => _ : eventListener;

	var url = $(that).attr("href");

	clearModalBody();

	showModal();

	fetch(url)
	  .then((data) => data.json())
	  .then((json) => {
	  	loadModalTitle(json.title);
	  	loadModalBody(json.html_content);
	  	event();
	  });
}

// caregivers assign task lists to patients
// when a task list is selected
// show task items for the selected list
// show date input
function addAssignTaskListeners() {
	$("#select-task-list").on("change", function(e){
		$(".form-check").hide();

		var selected = $(this).val();

		$("#instruction_task_list_id").val(selected);

		$(".task-list-" + selected).show();
		
		$("#instructions-date").show();

		$("#include-items").show();
	});
}

function addViewTaskListListeners() {
	$(".display-task-item-body").on("click", function(e){
		var that = $(this);
		flipTriangle(that);
	});

	$(".selected-task").on("click", function(e){
		var url = "/update_selected_task/" + $(this).val()
		// update the specific selected task
		// disable the checkbox
		// update the completed on date
		// if all are checked, replace the task list with a new html template congratulating completion
		fetch(url)
		  .then((data) => data.json())
		  .then((json) => {

		  	if (json.selected_task != null) { 
		  		// not all tasks are complete
		  		// update the individual instruction selected task
		  		var id = json.selected_task.id;
		  		
		  		$("#selected_task[value='" + id + "']").prop("disabled", true);
		  		$("#task-item-due-" + id).html("<i>Completed: " + json.selected_task.complete_date + "</i>");
		  		$("#task-due-warning").html("");
		  	} else { 
		  		// all tasks are complete, update modal
			  	loadModalTitle(json.title);
			  	loadModalBody(json.html_content);
		  	}
		  });
	});
}

function flipTriangle(that) {
	if (that.html() == "▼") 
		that.html("▲");
	else 
		that.html("▼");
}
