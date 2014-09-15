function loginUserClick(e) {
	e.preventDefault();
	var loginUser = $(e.currentTarget).closest('.login-user'),
		container = loginUser.closest('.login-user-container'),
		photo = loginUser.find('.user-photo'),
		password = loginUser.find('.password-area'),
		loginBack = $('.login-back-link');

	$('.login-user').each(function (i, x) {
		if (loginUser[0] != x) {
			$(x).closest('.login-user-container').addClass('inactive');
		}
	});

	container.addClass('selected');
	loginBack.addClass('active');
	setTimeout(function () {
		password.find('input[type=password]').focus();
	}, 400);
}

function loginBackClick(e) {
	e.preventDefault();
	console.log(e.currentTarget);
	$('.login-user').each(function (i, x) {
		var loginUser = $(x),
			container = loginUser.closest('.login-user-container'),
			photo = loginUser.find('.user-photo'),
			password = loginUser.find('.password-area');

		container.removeClass('inactive');
		container.removeClass('selected');
		//password.animate({height: '0em'}, 200);
	});
	$('.login-back-link').removeClass('active');
	//.animate({opacity: 0}, 200);
}

function initLogins() {
	$('.login-user-info').click(loginUserClick);
	$('.login-back-link').click(loginBackClick)
}


$(initLogins);