var collapsed = false;
var activeFolder = "";

function Rect(options) {
	options = options || {};
	this.left = options['left'] || null;
	this.top = options['top'] || null;
	this.width = options['width'] || null;
	this.height = options['height'] || null;
	this.right = options['right'] || null;

	this.setLeft = function(value) {
		this.left = value;
		return this;
	}
	this.setTop = function(value) {
		this.top = value;
		return this;
	}
	this.setWidth = function(value) {
		this.width = value;
		return this;
	}
	this.setHeight = function(value) {
		this.height = value;
		return this;
	}
	this.centerX = function(availableWidth) {
		this.left = (availableWidth - this.width) / 2;
		return this;
	}
}

jQuery.fn.extend({
	moveToRect: function(rect) {
		this
			.css('left', rect.left + 'px')
			.css('right', rect.right + 'px')
			.css('top', rect.top + 'em')
			.css('width', rect.width + 'px')
			.css('height', rect.height + 'em');
		},
	animateMoveToRect: function(rect, time, ease, completeFunc) {
		this.animate({ left: rect.left + 'px', right: rect.right + 'px', top: rect.top + 'em', width: rect.width + 'px', height: rect.height + 'em' }, time, ease, completeFunc);
	}
});

$(function () {
	$.templates("taskTmpl", {markup: "#task-template", allowCode: true });
});

function initMainAreaLayout() {
	$(function () {
	initTiles();
	layoutMainArea();
	$(window).resize(layoutMainArea);
	$('.task-info-item > div')
		.click(tileSelect);
	logoBar
		.click(toGrid);
	$('#task-shadow').css('opacity', 0);
	$('#task-list').css('opacity', 0);
	$('.data-area').css('opacity', 0);
});
}


function initTiles() {
	$('.task-info')
		.css('position', 'initial');
	$('.task-info-item > div')
		.css('position', 'absolute');
	performBox = $('.task-info-group-performing')
	performBox
		.css('position', 'absolute');

	itemsToPerform = [
		$('.task-info-performing'),
		$('.task-info-to_accept'),
		$('.task-info-long_tasks'),
		$('.task-info-to_approve'),
		$('.task-info-to_sign'),
		$('.task-info-informational')];
	itemRects = new Array(itemsToPerform.count);

	issuedBox = $('.task-info-group-issued');
	issuedBox
		.css('position', 'absolute');

	itemsIssued = [
		$('.task-info-issued'),
		$('.task-info-long_issued'),
		$('.task-info-delegated')];
	issuedRects = new Array(itemsToPerform.count);

	headerBar = $('.header-bar');

	headerActions = $('.header-bar > .header-actions');
	headerActions
		.css('position', 'absolute');
	headerActionLinks = $('.header-actions ul li a');

	userControl = $('.header-bar > .user-control');
	userControl
		.css('position', 'absolute');

	staskInfoGrid = $('.task-info-grid');
	logoBar = $('.logo-bar');
}

function layoutMainArea() {
	var body = $('body');
	var appArea = $('.app-area');
	if (appArea.width() < body.width())
		appArea.css('left', ($('body').width() - appArea.width()) / 2);
	else
		appArea.css('left', '0px');

	if (collapsed)
		return;

	calcLayout();

	headerActions.moveToRect(headerActionsRect);
	userControl.moveToRect(userControlRect);

	performBox.moveToRect(performBoxRect);

	for (var i = 0; i < itemsToPerform.length; i++)
		itemsToPerform[i].moveToRect(itemRects[i]);

	issuedBox.moveToRect(issuedBoxRect);

	for (var i = 0; i < itemsIssued.length; i++)
		itemsIssued[i].moveToRect(issuedRects[i]);
}

function calcLayout() {
	var container = $('.app-area');
	var width = container.width();
	var height = container.height();

	var issuedTop = 3.5;

	if (width >= 800)
	{
		var tileWidth = 240;
		var tileSep = 20;
		var shift = tileSep / 2;
		var left = shift;
		var top = 3.5;
		var topShift = 7;
		var leftShift = tileWidth + tileSep;
		var tileCount = 3;
		var tileHeight = 6;
		var topSpace = 0.5;

		performBoxRect = new Rect({
			top: 7.5,
			width: tileWidth * 3 + tileSep * 3
		}).centerX(width);

		$('.task-info-item').removeClass('single-line');
	}
	else
	{
		var tileSep = 20;
		var shift = tileSep / 2;
		var left = shift;
		var top = 3;
		var topShift = 7;
		var tileCount = 3;
		var tileHeight = 6;
		var topSpace = 0.5;

		performBoxRect = new Rect({
			left: tileSep / 2,
			top: 6.5,
			width: width - tileSep
		});

		if (width < 400) {
			$('.task-info-item').addClass('single-line');
			tileWidth = width - tileSep * 2;
			tileCount = 1;
			topShift = 3.5;
			tileHeight = 3;
			issuedBoxTop = '34.5em'
			issuedBoxHeight = '15em'
		}
		else
		if (width < 600) {
			tileCount = 2;
			topSpace -= 0.3;
			topShift = 5.6;
			tileHeight = 5;
			issuedBoxTop = '31.5em'
			issuedBoxHeight = '17em'
			$('.task-info-item').removeClass('single-line');
		}
		else {
			$('.task-info-item').removeClass('single-line');
		}
		var tileWidth = (width - (1 + tileCount) * tileSep) / tileCount;
		var leftShift = tileWidth + tileSep;
		top += topSpace;
	}

	performBoxRect.setHeight(4.5 + Math.floor(((itemsToPerform.length + tileCount - 1) / tileCount)) * (tileHeight + topSpace) - topSpace);

	issuedBoxRect = new Rect({
		left: performBoxRect.left,
		top: performBoxRect.top + performBoxRect.height + topSpace * 2,
		width: performBoxRect.width,
		height: 4.5 + Math.floor(((itemsIssued.length + tileCount - 1) / tileCount)) * (tileHeight + topSpace) - topSpace
	});

	var actionsLeft = 85;
	if (performBoxRect.left > actionsLeft)
		actionsLeft = performBoxRect.left;

	headerActionsRect = new Rect({
		left: actionsLeft,
		top: performBoxRect.top - 5,
		//width: performBoxRect.width * 0.6 + 50,
		height: 5
	});

	userControlRect = new Rect({
		right: 10,
		top: performBoxRect.top - 5,
		width: 300,
		height: 5.2
	});

	for(i in itemsToPerform)
	{
		itemRects[i] = new Rect(
		{
			left: left,
			top: top,
			width: tileWidth,
			height: tileHeight
		});
		if (i % tileCount == tileCount - 1) {
			left = shift;
			top += topShift;
		}
		else {
			left += leftShift;
		}
	}

	left = shift;
	for(i in itemsIssued)
	{
		issuedRects[i] = new Rect(
		{
			left: left,
			top: issuedTop,
			width: tileWidth,
			height: tileHeight
		});
		if (i % tileCount == tileCount - 1) {
			left = shift;
			issuedTop += topShift;
		}
		else {
			left += leftShift;
		}
	}
}

function tileSelect(event) {
	var color, foreColor;
	event.preventDefault();
	folder = $(event.currentTarget).data('folder');
	if (collapsed) {
		switch_to_list(folder);
		for(i in itemsToPerform)
		{
			color = (i >= 2) ? "#EDF2E1" : "#FDEBDC";
			foreColor = "#777";
			if (itemsToPerform[i].data('folder') == folder)
			{
				color = (i >= 2) ? "#C8D9A6" : "#F7C6A3";
				foreColor = "#696969";
			}
			itemsToPerform[i]
				.animate({ "background-color": color}, 200);
			itemsToPerform[i].children('.header')
				.animate({ color: foreColor }, 200);
		}
		for(i in itemsIssued)
		{
			color = "#E1F1F5";
			foreColor = "#777";
			if (itemsIssued[i].data('folder') == folder)
			{
				color = "#A5D6E2";
				foreColor = "#777";
			}
			itemsIssued[i]
				.animate({ "background-color": color}, 200);
			itemsIssued[i].children('.header')
				.animate({ color: foreColor }, 200);
		}
		return;
	}

	var tileWidth = 240;
	var tileSep = 20;
	var left = 10;
	var top = 3.5;
	var topShift = 3.5;

	performBox
		.animate({ height: '24.5em', width: tileWidth + tileSep, left: 10, top: '6em' }, 400, 'easeOutCirc', function () { collapsed = true; });
	performBox.children('.header')
		.animate({ 'background-color': '#D6CEC3', color: '#FFF'}, 400, 'easeOutCirc');
	for(i in itemsToPerform)
	{
		color = "#FDEBDC";
		if (i >= 2)
			color = "#EDF2E1";
		if (itemsToPerform[i].data('folder') == folder)
			itemsToPerform[i]
				.animate({ left: left, width: tileWidth, height: '3em', top: top + 'em'}, 400, 'easeOutCirc');
		else
			itemsToPerform[i]
				.animate({ "background-color": color, left: left, width: tileWidth, height: '3em', top: top + 'em'}, 400, 'easeOutCirc');
		itemsToPerform[i].children('.icon')
			.animate({ opacity: 0}, 400, 'easeOutCirc');
		itemsToPerform[i].children('.new')
			.animate({ bottom: '0.2em' }, 400, 'easeOutCirc');
		if (itemsToPerform[i].data('folder') == folder)
			itemsToPerform[i].children('.header')
				.animate({ 'margin-right': '4em', 'margin-top': '-0.3em' }, 400, 'easeOutCirc');
		else
			itemsToPerform[i].children('.header')
				.animate({ color: '#777', 'margin-right': '4em', 'margin-top': '-0.3em' }, 400, 'easeOutCirc');
		top += topShift;
	}
	issuedBox
		.animate({ height: '14em', width: tileWidth + tileSep, left: 10, top: '31em' }, 400, 'easeOutCirc');
	issuedBox.children('.header')
		.animate({ 'background-color': '#D6CEC3', color: '#FFF'}, 400, 'easeOutCirc');
	var top = 3.5;
	for(i in itemsIssued)
	{
		if (itemsIssued[i].data('folder') == folder)
			itemsIssued[i]
				.animate({ left: left, width: tileWidth, height: '3em', top: top + 'em'}, 400, 'easeOutCirc');
		else
			itemsIssued[i]
				.animate({ "background-color": "#E1F1F5", left: left, width: tileWidth, height: '3em', top: top + 'em'}, 400, 'easeOutCirc');
		itemsIssued[i].children('.icon', 'easeOutCirc')
			.animate({ opacity: 0}, 400);
		itemsIssued[i].children('.new')
			.animate({ bottom: '0.2em' }, 400, 'easeOutCirc');
		if (itemsIssued[i].data('folder') == folder)
			itemsIssued[i].children('.header')
				.animate({ 'margin-right': '4em', 'margin-top': '-0.3em' }, 400, 'easeOutCirc');
		else
			itemsIssued[i].children('.header')
				.animate({ color: '#777', 'margin-right': '4em', 'margin-top': '-0.3em' }, 400, 'easeOutCirc');
		top += topShift;
	}
	headerActions
		.animate({ height: '4em', top: '0.7em', left: '85px' }, 400, 'easeOutCirc');
	headerActionLinks
		.animate({ color: '#E0E0E0'}, 400, 'easeOutCirc');
	headerBar
		.animate({ 'background-color': '#34AADC' }, 400, 'easeOutCirc');
	userControl
		.animate({ height: '5.2em', top: '1.2em', right: '10px', width: '300px' }, 400, 'easeOutCirc');
	logoBar
		.animate({ top: '0.7em' }, 400, 'easeOutCirc');

	/*taskInfoGrid
		.animate({ width: '4em', opacity: 1 }, 400, 'easeOutCirc');*/
	switch_to_list(folder);
	$('.data-area')
		.animate({ opacity:1 }, 400, 'easeInCirc');
}

function toGrid() {
	if (!collapsed)
		return;
	
	activeFolder = "";

	calcLayout();

	headerBar
		.animate({ 'background-color': '#FFFFFF' }, 400, 'easeOutCirc');
	headerActions
		.animateMoveToRect(headerActionsRect, 400, 'easeOutCirc');
	headerActionLinks
		.animate({ color: '#696969'}, 400, 'easeOutCirc');
	userControl
		.animateMoveToRect(userControlRect, 400, 'easeOutCirc');
	logoBar
		.animate({ top: '2.1em' }, 400, 'easeOutCirc');

	performBox
		.animateMoveToRect(performBoxRect, 400, 'easeOutCirc', function () { collapsed = false; });
	performBox.children('.header')
		.animate({ 'background-color': '#F7F7F7', color: '#696969'}, 400, 'easeOutCirc');
	for(i in itemsToPerform)
	{
		color = "#F7C6A3";
		if (i >= 2)
			color = "#C8D9A6";
		itemsToPerform[i]
			.animate({ "background-color": color, left: itemRects[i].left, width: itemRects[i].width, height: itemRects[i].height + 'em', top: itemRects[i].top + 'em'}, 400, 'easeOutCirc');
		itemsToPerform[i].children('.icon')
			.animate({ opacity: 1}, 400, 'easeInCirc');
		itemsToPerform[i].children('.new')
			.animate({ bottom: '0.5em' }, 400, 'easeOutCirc');
		itemsToPerform[i].children('.header')
			.animate({ color: '#696969', 'margin-right': 'inherit', 'margin-top': 'inherit' }, 400, 'easeOutCirc');
	}
	issuedBox
		.animateMoveToRect(issuedBoxRect, 400, 'easeOutCirc');
	issuedBox.children('.header')
		.animate({ 'background-color': '#F7F7F7', color: '#696969'}, 400, 'easeOutCirc');
	for(i in itemsIssued)
	{
		itemsIssued[i]
			.animate({ "background-color": "#A5D6E2", left: issuedRects[i].left, width: issuedRects[i].width, height: issuedRects[i].height + 'em', top: issuedRects[i].top + 'em'}, 400, 'easeOutCirc');
		itemsIssued[i].children('.icon')
			.animate({ opacity: 1}, 400, 'easeInCirc');
		itemsIssued[i].children('.new')
			.animate({ bottom: '0.5em' }, 400, 'easeOutCirc');
		itemsIssued[i].children('.header')
			.animate({ color: '#696969', 'margin-right': 'inherit', 'margin-top': 'inherit' }, 400, 'easeOutCirc');
	}
	/*taskInfoGrid
		.animate({ width: '0em', opacity: 0}, 400, 'easeOutCirc');*/
	$('.data-area')
		.animate({ opacity:0 }, 400, 'easeOutCirc');
}

function switch_to_list(folder) {
	$("#task-shadow").css('z-index', 1).css('opacity', 1);
	$("#task-list").css('opacity', 0);
	$("#task-list").html('');
    load_list(folder);
    activeFolder = folder;
}

function empty_list_text(folder) {
	if (folder == "performing") {
		var currentText = "поручения на исполнение"
	} else if (folder == "to_accept") {
		var currentText = "поручения на приемку"
	} else if (folder == "long_tasks") {
		var currentText = "поручения на приемку"
	} else if (folder == "to_approve") {
		var currentText = "поручения на согласование"
	} else if (folder == "to_sign") {
		var currentText = "поручения на подписание"
	} else if (folder == "informational") {
		var currentText = "поручения на ознакмоление"
	} else if (folder == "issued") {
		var currentText = "выданные Вами поручения"
	} else if (folder == "long_issued") {
		var currentText = "выданные Вами длительные поручения"
	} else if (folder == "delegated") {
		var currentText = "распределенные Вами поручения"
	}
	return currentText;
}

function load_list(folder) {
	$.get( "/task_info/" + folder + ".json", function (data) {
		fill_list(data);
		if ($("#task-list").html() == 0) {
			$("#task-list").html("<table class=\"fullsize table__content--center\"><td>Здесь Вы будете видеть " + empty_list_text(folder) + "</td></table>")
		}
	});
}

function fill_list(data) {
	for(i in data.task_list) {
		data.task_list[i].html_content = $('<div/>').text(data.task_list[i].content).html().replace("\n", "<br/>");
		data.task_list[i].deadline_time_till = "до " + data.task_list[i].deadline_time + " часов"
	}
	task_item = $("#task-list").html($.render.taskTmpl(data.task_list));
    $("#task-shadow").css('z-index', -1)
    	.animate({ opacity: 0 }, 400, 'easeOutCirc');
    $("#task-list")
    	.animate({ opacity: 1 }, 400, 'easeOutCirc', showTaskScroll);
	selectedTask = null;
    $(".task-area").click(task_select);
    init_task_actions($(task_item));
}

function task_select(event) {
	/*if (event.originalEvent.srcElement.nodeName == 'A')
		return;*/
	/*event.preventDefault();*/
	if (selectedTask == event.currentTarget)
		return;
	if (selectedTask)
		$(selectedTask).removeClass("selected");
	selectedTask = event.currentTarget;
	$(selectedTask).addClass("selected");
}

function init_task_actions(taskList) {
	taskList.find(".task-action-delegate").click(createSubTask);
	taskList.find(".task-action-complete").click(showTaskComplete);
	taskList.find(".task-action-reject").click(showTaskComplete);
	taskList.find(".task-action-cancel").click(closeTaskComplete);
	taskList.find(".task-action-error-close").click(closeErrorMessage);
	taskList.find(".task-comments").change(commentsChanged);
	taskList.find(".task-comments").keyup(commentsChanged);
	taskList.find(".task-comments").bind('paste', commentsChanged);
	tasks = taskList.find(".task-area");
	for (var i = 0; i < tasks.length; i++) {
		tasks[i].taskFiles = new TaskFiles($(tasks[i]));
		console.log($(tasks[i]));
		console.log($(tasks[i]).find('textarea'));
		var commentArea = $(tasks[i]).find('textarea');
	    commentArea
        	.change(taskContentAutoSize)
        	.keydown(taskContentAutoSize)
        	.keyup(taskContentAutoSize);
    	taskContentAutoSize(commentArea);
	}
}

function createSubTask(event) {
	event.preventDefault();

	var taskItem = $(event.currentTarget).parents('.task-area');
	var taskId = taskItem.data("task-id");
	var parentDocumentId = taskItem.find('.task-document').data("id");
	var content = taskItem.find('.task-content').data("value");
	var date = taskItem.find('.task-deadline-date').data("value");
	var time = taskItem.find('.task-deadline-time').data("value");

	var user_id = $('.user-info').data("value");
	var user_name = $('.user-name').data("value");

	var taskArea = $('.create-task-area');

	$('#Task-parent_task').data("id", taskId);
	$('#Task-parent_document').data("id", parentDocumentId);
	$('#Task-performer').val("").data("text", "").data("id", "");
	$('#Task-performer').lookupMulti('reset');
	$('.performer-quick-list li').removeClass('pressed');
	$('#Task-co_performers').val("").data("text", "").data("id", "");
	$('#Task-co_performers').lookupMulti('reset');
	$('#Task-informants').val("").data("text", "").data("id", "");
	$('#Task-informants').lookupMulti('reset');
	$('#Task-controller').lookupMulti('addToken', { id: user_id, name: user_name });
	$('#Task-content').val(content);
	taskContentAutoSize($('#Task-content'));
	if (date) {
		$('input.date-picker').val(date + " " + time);
	}
	else {
		$('input.date-picker').val("");
	}
	updateTaskDatePicker();

	taskFiles.clear();
	var files = taskItem.find('.task-file-ref');
	for (var i  = 0; i < files.length; i++) {
		var fileId = files[i].getAttribute("data-value"),
			fileName = files[i].getAttribute("data-name");
		taskFiles.addFile(fileName, fileId);
	}

	TaskActors().reset();
	TaskActors('controller').set();

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

function showTaskComplete(event) {
	event.preventDefault();

	var actionButton = $(event.currentTarget),
		dataArea = $('.data-area'),
 	    taskItem = actionButton.parents('.task-area'),
	    taskCompleteArea = taskItem.find('.task-complete-area'),
	    taskActions = taskItem.find('.task-actions'),
	    comments = taskCompleteArea.find('textarea'),
	    subActionItems = actionButton.find('.task-action-sub-actions li'),
	    taskActionsArea = taskItem.find('.task-actions-ok'),
	    subActions;

	if (subActionItems.length == 0)
	    subActions = [ 
			{ action: actionButton.data('action'), 
			  text: actionButton.text(), 
			  buttonText: 'OK (' + actionButton.text() + ')',
			  commentsRequired: actionButton.data('comments-required') }];
	else
		subActions = subActionItems.map(function (index, value) { 
			return { 
				action: value.getAttribute('data-action'),
			  	text: value.getAttribute('data-text'),
			  	buttonText: value.getAttribute('data-text'),
			  	commentsRequired: value.getAttribute('data-comments-required') == ("" + true)
			} 
		});

	taskActionsArea.html("");

	for (var i = 0; i < subActions.length; i++) {
		$("<a></a>")
	 		.attr('href', '#')
	 		.data('action', subActions[i].action)
	 		.data('action-text', subActions[i].text)
	 		.data('comments-required', subActions[i].commentsRequired)
			.text(subActions[i].buttonText)
			.click(completeTask)
			.appendTo(taskActionsArea);
	}

	if (subActionItems.length == 0) {
		comments.data('required', actionButton.data('comments-required'))
		if (comments.data('required'))
			comments.addClass('required');
		else
			comments.removeClass('required');
	}

	hideTaskScroll();
	initialScroll = dataArea.scrollTop();
	taskCompleteArea.animate({height: '60px', 'min-height': '60px'}, 400, 'easeOutCirc', function () { taskCompleteArea.css('height', 'auto')});
	taskActions.animate({'margin-top': '-2.5em'}, 400, 'easeOutCirc');
	comments.focus();
	dataArea.animate({scrollTop: taskItem.position().top + dataArea.scrollTop() - 10}, 200, 'easeOutCirc');
	taskItem.animate({height: '100%'}, 200, 'easeOutCirc', function () { 
		taskItem.css('display', 'block');
	});
	//dataArea.scrollTop(taskItem.position().top + dataArea.scrollTop() - 10);
}

function commentsChanged(event) {
	var comments = $(event.currentTarget);
	
	if (comments.data('required'))
		if (comments.val().trim() == "")
			comments.addClass('required');
		else
			comments.removeClass('required');
}

function closeTaskComplete(event) {
	event.preventDefault();

	var dataArea = $('.data-area'),
		taskItem = $(event.currentTarget).parents('.task-area'),
	    taskCompleteArea = taskItem.find('.task-complete-area'),
	    taskActions = taskItem.find('.task-actions'),
	    comments = taskCompleteArea.find('textarea');

	comments.val('');
	console.log("Comments = " + comments.val());
	taskContentAutoSize(comments);
    taskItem[0].taskFiles.clear();
	taskItem.css('display', 'table');
	taskCompleteArea.animate({height: '0em', 'min-height': '0em'}, 400, 'easeOutCirc');
	taskActions.animate({'margin-top': '0.5em'}, 400, 'easeOutCirc');
	taskItem.animate({height: '1px'}, 400, 'easeOutCirc');
	dataArea.animate({ scrollTop:initialScroll}, 400, 'easeOutCirc', showTaskScroll);
}

function completeTask(event) {
	event.preventDefault();

	var actionButton = $(event.currentTarget),
		taskItem = actionButton.parents('.task-area'),
		id = taskItem.data('id'),
	    taskCompleteArea = taskItem.find('.task-complete-area'),
	    taskActions = taskItem.find('.task-actions'),
	    comments = taskCompleteArea.find('textarea'),
	    commentsText = comments.val(),
	    actionError = taskItem.find('.task-action-error'),
	    actionProgress = taskItem.find('.task-action-progress'),
	    actionCloseBtn = taskItem.find('.task-action-error-close'),
	    actionMessage = taskItem.find('.task-action-message'),
	    actionLid = taskItem.find('.task-action-lid');

	if (actionButton.data("comments-required") && comments.val().trim() == "") {
	    actionMessage.text('Не задан комментарий');
	    actionError.text('Комментарий обязателен при завершении поручения с решением "' + actionButton.data('action-text') + '"').css('display', 'block');
	    actionProgress.css('display', 'none');
	    actionCloseBtn.css('display', 'inline-block');
	    actionLid.css('opacity', '0').css('display', 'block').animate({
	        opacity: 1
	    }, 400);
	    return;
	}

	var fileArray = taskItem.find('.task-files .task-file').map(function(i, file) {
                return $(file).data("id");
            }).toArray();

    var taskData = {
        task_action: actionButton.data('action'),
        comments: commentsText,
        files: fileArray
    };

    actionError.css('display', 'none');
    actionProgress.css('display', 'inline-block');
    actionCloseBtn.css('display', 'none');
    actionMessage.text('Завершение поручения');
    actionLid.css('opacity', '0').css('display', 'block').animate({
        opacity: 1
    }, 400);

    $.post('/task_info/' + id + '/perform.json', taskData)
        .done(function (data) {
        	var result = '';
            if (data && data.result)
                result = data.result;
        	onCompleteTaskDone(result, taskItem, actionMessage, actionProgress, actionLid);
        })
        .fail(function (data) {
            var errorText = "Внутренняя ошибка приложения";
            if (data.responseJSON && data.responseJSON.error)
                errorText = data.responseJSON.error;
            onCompleteTaskError(errorText, actionMessage, actionError, actionProgress, actionCloseBtn);
        });
}

function hideTaskScroll() {
	$('.data-area').css('overflow-y', 'hidden');
	$('#task-list').css('padding-right', '17px');
}

function showTaskScroll() {
	$('.data-area').css('overflow-y', 'scroll');
	$('#task-list').css('padding-right', '0px');
}


function onCompleteTaskError(errorMessage, message, error, progress, closeBtn) {
    message.text('Ошибка завершения поручения');
    error.text(errorMessage).css('display', 'block');
    progress.css('display', 'none');
    closeBtn.css('display', 'inline-block');
}

function onCompleteTaskDone(result, task, message, progress, lid) {
    message.text('Поручение завершено');
    progress.css('display', 'none');
    setTimeout(function() {
		hideTaskLid(lid, task, result);
    }, 1000);
}

function removeTask(task) {
	$('.data-area').css('overflow-y', 'overlay').animate({ scrollTop:initialScroll}, 400, 'easeOutCirc');
	task.css('display', 'block');
	task.animate({
		'height': '0px',
		'padding-bottom': '0px'
	}, 400, 'easeOutCirc', function() {
		if (activeFolder) {
			var total = $('.task-info-' + activeFolder).find('.total')
			if (+(total.text()) > 0)
				total.text(+(total.text()) - 1);
			var newTasks = $('.task-info-' + activeFolder).find('.new')
			if (task.data('new') && +(newTasks.text()) > 0) {
				newTasks.text(+(newTasks.text()) - 1);
				if (+(newTasks.text()) == 0)
					newTasks.removeClass('non-zero');
			}
		}
		task.remove();
		if (activeFolder) {
			if ($("#task-list").html() == 0) {
				$("#task-list").html("<table class=\"fullsize table__content--center\"><td>Здесь Вы будете видеть " + empty_list_text(activeFolder) + "</td></table>")
			}		
		}
	})
}

function closeErrorMessage(e) {
	event.preventDefault();

	var taskItem = $(event.currentTarget).parents('.task-area'),
	    actionLid = taskItem.find('.task-action-lid');

	hideTaskLid(actionLid, taskItem, '');
}

function hideTaskLid(lid, task, result) {
	lid.animate({
	    opacity: 0
	}, 200, 'easeOutCirc', function() {
	    lid.css('display', 'none');
    	if (result == 'folder_remove')
    		removeTask(task);
	});
}

function handleDocumentKey(e) 
{ 
	if ((e.which || e.keyCode) == 116)  // handling F5
		taskInfoRefresh(e);
};


$(function () {
	$(document).on("keydown", handleDocumentKey);	
})

