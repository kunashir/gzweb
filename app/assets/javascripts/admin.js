$(function () { initAdminArea(); });

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
	$('.admin-user-details-block').data("id", data['user']['id']).addClass('active');
	$('.admin-quick-performers-list').html("");
	var list = $('<ul></ul>')
		.addClass("sortable")
		.appendTo(".admin-quick-performers-list")
		.sortable({
			beforeStop: reorderPerformers
		});
	if (data["quick_performers"]) {
		data["quick_performers"].forEach(function (performer) {
			console.log(performer);
			$('<li></li>')
	    		.text(performer.employee_name)
	    		.data("id", performer.employee_id)
	    		.data("order", performer.order)
	    		.data("text", performer.employee_name)
				.appendTo(list);
		});
	}
}

function initAdminArea() {
	$('.admin-user').click(selectUser);
	$('.admin-user-new').find("form").submit(addUser);
	$('.admin-add-quick-performer .add').click(addQuickPerformers);
	$('.admin-change-user-password .submit').click(changePassword);
	$('.admin-refresh-block .submit').click(refreshUserData)
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
	    	$("<li></li>")
	    		.text(person.text)
	    		.data("id", person.id)
	    		.data("order", count++)
	    		.data("text", person.text)
	    		.appendTo(list);
    	}
    });
    editor.lookupMulti('reset');
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