$(function () { initAdminArea(); });

function selectUser(e) {
	if (e.target.nodeName == 'A')
		return;
	e.preventDefault();
	$.get('/admin/user_details', { user_id: $(e.currentTarget).data("id") }, setUserDetails);
	$('.admin-user').removeClass('selected');
	$(e.currentTarget).addClass('selected');
}

function setUserDetails(e) {
	$('.admin-user-details-block').data("id", "").addClass('active');
}

function initAdminArea() {
	$('.admin-user').click(selectUser);
	$('.admin-user-new').find("form").submit(addUser);
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
