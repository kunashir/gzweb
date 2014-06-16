$(function () {
	$('.create-task-link').click(createNewTask);
})

function createNewTask(event) {
	event.preventDefault();

	var taskArea = $('.create-task-area');

	$('#Task-performer').val("").data("text", "").data("id", "");
	$('.performer-quick-list li').removeClass('pressed');
	$('#Task-co_performers').val("").data("text", "").data("id", "");
	$('#Task-informants').val("").data("text", "").data("id", "");
	$('#Task-controller').val("").data("text", "").data("id", "");
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