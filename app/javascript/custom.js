$( document ).on('turbolinks:load', function() {
	$("#add-task-list").on("click", function(e){
		loadModalContent(e, this)
	});

	$("#add-task-item").on("click", function(e){
		loadModalContent(e, this)
	});

	$("#add-patient").on("click", function(e){
		loadModalContent(e, this)
	});

	$(".task-list-edit").on("click", function(e){
		loadModalContent(e, this)
	});

	$(".task-item-edit").on("click", function(e){
		loadModalContent(e, this)
	});

	$(".patient-edit").on("click", function(e){
		loadModalContent(e, this)
	});

	$(".patient-instructions-assign").on("click", function(e){
		loadModalContent(e, this, addOnChangeListener)
	});

	$(".patient-instructions-view").on("click", function(e){
		// loadModalContent(e, this, addOnChangeListener)
	});
});

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

function loadModalContent(e, that, eventListener) {
	e.preventDefault();
		
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

function addOnChangeListener() {
	$("#select-task-list").on("change", function(e){
		$(".form-check").hide();

		var selected = $(this).val();

		$("#instruction_task_list_id").val(selected);

		$(".task-list-" + selected).show();
		
		$("#instructions-date").show();

		$("#include-items").show();
	});
}