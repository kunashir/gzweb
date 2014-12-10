$(function () { initAdminArea(); });

function twoDigitStr(n) {
	if (n < 10)
		return "0" + n;
	return "" + n;
}

function russianFormatDate(date) {
	return twoDigitStr(date.getDate()) 
		+ "." + twoDigitStr(date.getMonth() + 1)
		+ "." + date.getFullYear()
		+ " " + twoDigitStr(date.getHours())
		+ ":" + twoDigitStr(date.getMinutes())
		+ ":" + twoDigitStr(date.getSeconds())
}

function selectUser(e) {
	if (e.target.nodeName == 'A')
		return;
	e.preventDefault();
	if ($('.admin-user-details-block').data("id") == $(e.currentTarget).data("id"))
		return;
	$('.admin-user-details-block').removeClass('active');
	$.get(
		'/admin/user_details', 
		{ user_id: $(e.currentTarget).data("id") }, 
		setUserDetails);
	$('.admin-user').removeClass('selected');
	$(e.currentTarget).addClass('selected');
}

function setUserDetails(data) {
	console.log(data);
	$('.admin-refresh-block .count').text(data['task_count']);
	if (data['user']['last_refresh_date'])
		$('.admin-refresh-block .last-refresh-date').text(russianFormatDate(new Date(data['user']['last_refresh_date'])));
	else
		$('.admin-refresh-block .last-refresh-date').text('<нет>');
	$('.admin-refresh-block .refresh-period input').val(data['user']['refresh_minutes']);
	$('.admin-refresh-block .refresh-period input').data('val', data['user']['refresh_minutes']);
	$('.admin-user-details-block').data("id", data['user']['id']).addClass('active');
	$('.admin-quick-performers-list').html("");
	var controllerEditor = $('.admin-user-controller-block').find('.edit-lookup-multi');
	if (data['user']['controller_id'])
		controllerEditor.lookupMulti('addToken', { id: data['user']['controller_id'], name: data['controller_name'] });
	else
		controllerEditor.lookupMulti('reset');
	var list = $('<ul></ul>')
		.addClass("sortable")
		.appendTo(".admin-quick-performers-list")
		.sortable({
			beforeStop: reorderPerformers
		});
	if (data["quick_performers"]) {
		data["quick_performers"].forEach(function (performer) {
    		createQuickPerformerLi(performer.employee_id, performer.employee_name)
				.appendTo(list);
		});
	}
}

function initAdminArea() {
	$('.admin-user').click(selectUser);
	$('.admin-user-new').find("form").submit(addUser);
	$('.admin-add-quick-performer .add').click(addQuickPerformers);
	$('.admin-change-user-password .submit').click(changePassword);
	$('.admin-user-controller-block .submit').click(setUserController)
	$('.admin-refresh-block .submit').click(refreshUserData)
	$('.admin-refresh-block .refresh-period input').blur(onRefreshPeriodBlur);
	$('.admin-refresh-block .refresh-period input').keypress(onRefreshPeriodKeyPress);
}

function addUser(e) {
	var password = $('.admin-user-new').find('.password');
	if (!password.val()) {
		e.preventDefault();
		return;
	}
    var persons = $('.admin-user-new').find('.edit-lookup-multi').lookupMulti('widget')().selection;
    if (!persons || persons.length == 0) {
    	e.preventDefault();
    	return;
    }
	$('.admin-user-new').find('.edit-lookup-multi').val(persons[0].id);
}

function setUserController(e) {
	e.preventDefault();
	var editor = $('.admin-user-controller-block').find('.edit-lookup-multi');
    var persons = editor.lookupMulti('widget')().selection;
    var controllerID = null;
    if (persons && persons.length > 0)
    	controllerID = persons[0].id;
	$.post("admin/save_controller",
		{	
			user_id: $('.admin-user-details-block').data("id"),
			controller_id: controllerID
		})
		.done(
		function () {
			$('.admin-user-controller-block .message')
				.text('Контролер изменен')
				.css('color', 'green')
				.animate({ opacity: 1}, 200, function () {
					setTimeout(function () {
						$('.admin-user-controller-block .message').animate({opacity:0}, 400);
					},
					1000);
				});
		})
		.fail(
		function () {
			$('.admin-user-controller-block .message')
				.text('Ошибка сохранения контролера')
				.css('color', '#C20B0B')
				.animate({ opacity: 1}, 200, function () {
					setTimeout(function () {
						$('.admin-user-controller-block .message').animate({opacity:0}, 400);
					},
					1000);
				});		
		});		
}

function addQuickPerformers(e) {
	e.preventDefault();
	var editor = $('.admin-add-quick-performer').find('.edit-lookup-multi');
    var persons = editor.lookupMulti('widget')().selection;
    if (!persons || persons.length == 0) {
    	return;
    }
    var list = $('.admin-quick-performers-list ul');
    var count = list.find('li').length
    persons.forEach(function (person) {
    	var found = false;
    	var items = list.find('li');
    	for (var i = 0; i < items.length; i++) {
    		if ($(items[i]).data("id") == person.id) {
    			found = true;
    			break;
    		}
    	}
    	if (!found) {
    		createQuickPerformerLi(person.id, person.text)
	    		.appendTo(list);
    	}
    });
    editor.lookupMulti('reset');
    saveQuickPerformers();
}

function createQuickPerformerLi(id, name)
{
	li = $("<li></li>").data("id", id).data("text", name);
	table = $("<div></div>").addClass('quick-performer').appendTo(li);
	name = $("<div></div>").addClass('name').text(name).appendTo(table);
	remove = $("<a></a>").addClass('remove').text("×").click(removeQuickPerformer).appendTo(table);

	return li;
}

function removeQuickPerformer(e) {
	$(e.target).closest('li').remove();
	saveQuickPerformers();
}

function saveQuickPerformers() {
	var list = $('.admin-quick-performers-list ul');
	var items = list.find('li');
	var performers = [];
	var k = 0;
	for (var i = 0; i < items.length; i++) {
		if ($(items[i]).data("id"))
			performers[k++] = $(items[i]).data("id");
	}
	console.log(performers);
	$.post("admin/save_quick_performers",
		{	
			user_id: $('.admin-user-details-block').data("id"),
			quick_performers: performers
		});
}

function reorderPerformers(event, ui) {
	saveQuickPerformers();
}

function changePassword(e) {
	e.preventDefault();
	var newPassword = $('.admin-change-user-password input').val();
	if (newPassword.length == 0) {
		$('.admin-password-block .message')
			.text('Пароль не задан')
			.css('color', '#C20B0B')
			.animate({ opacity: 1}, 200, function () {
				setTimeout(function () {
					$('.admin-password-block .message').animate({opacity:0}, 400);
				},
				1000);
			});
	}
	else {
		$.post('/admin/set_user_password',
			{
				user_id: $('.admin-user-details-block').data("id"),
				password: newPassword
			})
			.done(
			function () {
				$('.admin-password-block .message')
					.text('Пароль изменен')
					.css('color', 'green')
					.animate({ opacity: 1}, 200, function () {
						setTimeout(function () {
							$('.admin-password-block .message').animate({opacity:0}, 400);
						},
						1000);
					});
			})
			.fail(
			function () {
				$('.admin-password-block .message')
					.text('Ошибка установки пароля')
					.css('color', '#C20B0B')
					.animate({ opacity: 1}, 200, function () {
						setTimeout(function () {
							$('.admin-password-block .message').animate({opacity:0}, 400);
						},
						1000);
					});		
			});
	}
}

function refreshUserData() {
	$('.admin-refresh-block .submit').addClass('in_progress');
	$.post('/admin/refresh_user',
		{ 
			user_id: $('.admin-user-details-block').data("id")
		})
		.done(
			function (data) {
				$('.admin-refresh-block .count')
					.text(data["task_count"])
				$('.admin-refresh-block .message')
					.text('Данные обновлены')
					.css('color', 'green')
					.animate({ opacity: 1}, 200, function () {
						setTimeout(function () {
							$('.admin-refresh-block .message').animate({opacity:0}, 400);
						},
						1000);
					});
			})
		.fail(
			function () {
				$('.admin-refresh-block .message')
					.text('Ошибка обновления данных')
					.css('color', '#C20B0B')
					.animate({ opacity: 1}, 200, function () {
						setTimeout(function () {
							$('.admin-refresh-block .message').animate({opacity:0}, 400);
						},
						1000);
					});		
			})
		.always(
			function() {
				$('.admin-refresh-block .submit').removeClass('in_progress');
			});
}

function onRefreshPeriodBlur(e) {
	saveRefreshPeriod();
}

function onRefreshPeriodKeyPress(e) {
	if (e.charCode >= '48' && e.charCode <= '57')
		return;
	if (e.keyCode == 13)
		saveRefreshPeriod();
	e.preventDefault();
}

function saveRefreshPeriod() {
	var periodInput = $('.admin-refresh-block .refresh-period input'),
	    value = periodInput.val() || '',
	    initialValue = periodInput.data('val') || '';

	if (value.trim().length == 0) {
		if (initialValue.trim().length == 0)
			return;
		periodInput.data('val', '');
		periodInput.val('');
		$.post('/admin/set_user_refresh_period',
			{
				user_id: $('.admin-user-details-block').data("id"),
				refresh_period: ''
			});
		return;
	}

	if (!+value) {
		periodInput.val(initialValue);
	}
	else {
		periodInput.data('val', "" + (+value));
		$.post('/admin/set_user_refresh_period',
			{
				user_id: $('.admin-user-details-block').data("id"),
				refresh_period: +value
			});
	}
}