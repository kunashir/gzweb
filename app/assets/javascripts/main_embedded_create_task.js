$(function () {
	$('.create-task-link').click(createNewTask);
})

function createNewTask(event) {
	event.preventDefault();

	var taskArea = $('.create-task-area');

	$('#Task-parent_task').data("id", "");
	$('#Task-parent_document').data("id", "");
	$('#Task-performer').val("").data("text", "").data("id", "");
	$('#Task-performer').lookupMulti('reset');
	$('.performer-quick-list li').removeClass('pressed');
	$('#Task-co_performers').val("").data("text", "").data("id", "");
	$('#Task-co_performers').lookupMulti('reset');
	$('#Task-informants').val("").data("text", "").data("id", "");
	$('#Task-informants').lookupMulti('reset');
	$('#Task-controller').val("").data("text", "").data("id", "");
	$('#Task-controller').lookupMulti('reset');
	$('#Task-content').val("");
	$('input.date-picker').val("");
	var date = new Date();
	$('div.date-picker').
		datepicker('setDate', date.getDate() + "." + (date.getMonth() + 1) + "." + date.getFullYear()).
		addClass('unset');
	$('.task-files .task-file').remove();
	actors.reset();

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