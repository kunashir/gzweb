function attachUpdates() {
	$('.task-info-refresh').click(taskInfoRefresh);
}

function taskInfoRefresh(e) {
	e.preventDefault();
	$(".task-info-refresh").parent("li").addClass("in-progress");
	$.post("/task_info/refresh.json", "", updateTaskInfo);
}

function updateTaskInfo() {
	$.get("/task_info.json", "", loadTaskInfo);
}

function loadTaskInfo(result) {
	task_info = result.task_info;
	fields = ['performing', 'to_accept', 'long_tasks',
	          'to_approve', 'to_sign', 'informational',
	          'issued', 'long_issued', 'delegated']
	for (var i = 0; i < fields.length; i++) {
		eval("$('.task-info-" + fields[i] + " .total').html(task_info." + fields[i] + ");");
		eval("$('.task-info-" + fields[i] + " .new').html(task_info." + fields[i] + "_new);");
		newCount = eval("task_info." + fields[i] + "_new");
		if (newCount == 0)
			eval("$('.task-info-" + fields[i] + " .new').removeClass('non-zero');");
		else
			eval("$('.task-info-" + fields[i] + " .new').addClass('non-zero');");
	}
	if (activeFolder)
		switch_to_list(activeFolder);
	$(".task-info-refresh").parent("li").removeClass("in-progress");
}

$(attachUpdates);