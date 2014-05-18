function attachUpdates() {
	$('.task-info-refresh').click(taskInfoRefresh);
}

function taskInfoRefresh(e) {
	e.preventDefault();
	$.get(
		"/task_info.json",
		"",
		loadTaskInfo);
}

function loadTaskInfo(result) {
	task_info = result.task_info;
	console.log(task_info);
	fields = ['performing', 'to_accept', 'long_tasks',
	          'to_approve', 'to_sign', 'informational',
	          'issued', 'long_issued', 'delegated']
	for (i in fields) {
		eval("$('.task-info-" + fields[i] + " .total').html(task_info." + fields[i] + ");");
		eval("$('.task-info-" + fields[i] + " .new').html(task_info." + fields[i] + "_new);");
		newCount = eval("task_info." + fields[i] + "_new");
		if (newCount == 0)
			eval("$('.task-info-" + fields[i] + " .new').removeClass('non-zero');");
		else
			eval("$('.task-info-" + fields[i] + " .new').addClass('non-zero');");
	}
	//$('.task-info-performing .total').html(task_info.performing);
}

$(attachUpdates);