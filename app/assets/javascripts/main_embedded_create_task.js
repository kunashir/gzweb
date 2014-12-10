$(function () {
	$('.create-task-link').click(createNewTask);
})

function createNewTask(event) {
	event.preventDefault();

	var taskArea = $('.create-task-area');
	var controller_id = $('.user-info').data("controller-id");
	var controller_name = $('.user-info').data("controller-name");

	$('#Task-parent_task').data("id", "");
	$('#Task-parent_document').data("id", "");
	$('#Task-performer').val("").data("text", "").data("id", "");
	$('#Task-performer').lookupMulti('reset');
	$('.performer-quick-list li').removeClass('pressed');
	$('#Task-co_performers').val("").data("text", "").data("id", "");
	$('#Task-co_performers').lookupMulti('reset');
	$('#Task-informants').val("").data("text", "").data("id", "");
	$('#Task-informants').lookupMulti('reset');
	$('#Task-controller').lookupMulti('reset');
	if (controller_id) 
		$('#Task-controller').val("").data("text", controller_name).data("id", controller_id).
			lookupMulti('addToken', { id: controller_id, name: controller_name });
	else
		$('#Task-controller').val("").data("text", "").data("id", "");
	$('#Task-content').val("");
	$('input.date-picker').val("");
	updateTaskDatePicker();
	$('.task-files .task-file').remove();
	TaskActors().reset();
	TaskActors("controller").set();

	taskArea
		.css('opacity', 0)
		.css('display', 'block')
		.animate({'opacity': 1}, 400, 'easeOutCirc');

	taskActions.closeHandler = function () {
		taskArea
			.animate({'opacity': 0}, 400, 'easeOutCirc',
				function () {
					taskArea.css('display', 'none');
				});
	}
}