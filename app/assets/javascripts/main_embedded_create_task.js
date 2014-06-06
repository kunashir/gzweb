$(function () {
	$('.create-task-link').click(createNewTask);
})

function createNewTask(event) {
	event.preventDefault();

	var taskArea = $('.create-task-area');

	taskArea
		.css('opacity', 0)
		.css('display', 'block')
		.animate({'opacity': 1}, 400, 'easeOutCirc');

	console.log(taskActions);
	console.log(taskActions.closeHandler);
	taskActions.closeHandler = function () {
		taskArea
			.animate({'opacity': 0}, 400, 'easeOutCirc',
				function () {
					taskArea.css('display', 'none');
				});
	}
	console.log(taskActions.closeHandler);
}