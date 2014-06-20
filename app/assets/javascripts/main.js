var collapsed = false;

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

function initMainAreaLayout() {
	$(function () {
	initTiles();
	layoutMainArea();
	$(window).resize(layoutMainArea);
	$('.task-info-item > div')
		.click(tileSelect);
	taskInfoGrid
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

	headerActions = $('.header-bar > .header-actions');
	headerActions
		.css('position', 'fixed');

	userControl = $('.header-bar > .user-control');
	userControl
		.css('position', 'fixed');

	taskInfoGrid = $('.task-info-grid');
}

function layoutMainArea() {
	if (collapsed)
		return;

	calcLayout();

	headerActions.moveToRect(headerActionsRect);
	userControl.moveToRect(userControlRect);

	performBox.moveToRect(performBoxRect);

	for(i in itemsToPerform)
		itemsToPerform[i].moveToRect(itemRects[i]);

	issuedBox.moveToRect(issuedBoxRect);

	for(i in itemsIssued)
		itemsIssued[i].moveToRect(issuedRects[i]);
}

function calcLayout() {
	var width = $(window).width();
	var height = $(window).height();

	var issuedTop = 3.5;

	if (width > 800)
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
			top: 6.5,
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

	headerActionsRect = new Rect({
		left: performBoxRect.left - 70,
		top: performBoxRect.top - 5,
		width: performBoxRect.width * 0.6 + 70,
		height: 5
	});

	userControlRect = new Rect({
		right: width - performBoxRect.left - performBoxRect.width,
		top: performBoxRect.top - 4.5,
		width: performBoxRect.width * 0.4,
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
				foreColor = "#333";
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
		.animate({ height: '4em', top: '0em', left: tileWidth + tileSep, width: 3 * tileWidth }, 400, 'easeOutCirc');
	userControl
		.animate({ height: '5.2em', top: '1.2em', right: '20px', width: tileWidth }, 400, 'easeOutCirc');
	taskInfoGrid
		.animate({ width: '4em', opacity: 1 }, 400, 'easeOutCirc');
	switch_to_list(folder);
	$('.data-area')
		.animate({ opacity:1 }, 400, 'easeInCirc');
}

function toGrid() {
	if (!collapsed)
		return;

	calcLayout();

	performBox
		.animateMoveToRect(performBoxRect, 400, 'easeOutCirc', function () { collapsed = false; });
	headerActions
		.animateMoveToRect(headerActionsRect, 400, 'easeOutCirc');
	userControl
		.animateMoveToRect(userControlRect, 400, 'easeOutCirc');
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
			.animate({ color: '#333', 'margin-right': 'inherit', 'margin-top': 'inherit' }, 400, 'easeOutCirc');
	}		
	issuedBox
		.animateMoveToRect(issuedBoxRect, 400, 'easeOutCirc');
	for(i in itemsIssued)
	{
		itemsIssued[i]
			.animate({ "background-color": "#A5D6E2", left: issuedRects[i].left, width: issuedRects[i].width, height: issuedRects[i].height + 'em', top: issuedRects[i].top + 'em'}, 400, 'easeOutCirc');
		itemsIssued[i].children('.icon')
			.animate({ opacity: 1}, 400, 'easeInCirc');
		itemsIssued[i].children('.new')
			.animate({ bottom: '0.5em' }, 400, 'easeOutCirc');
		itemsIssued[i].children('.header')
			.animate({ color: '#333', 'margin-right': 'inherit', 'margin-top': 'inherit' }, 400, 'easeOutCirc');
	}
	taskInfoGrid
		.animate({ width: '0em', opacity: 0}, 400, 'easeOutCirc');
	$('.data-area')
		.animate({ opacity:0 }, 400, 'easeOutCirc');
}

function switch_to_list(folder) {
	$("#task-shadow").css('z-index', 1).css('opacity', 1);
	$("#task-list").css('opacity', 0);
	$("#task-list").html('');
    load_list(folder);
}

function load_list(folder) {
	$.get( "/task_info/" + folder + ".json", function (data) {
		fill_list(data);
	});
}

function fill_list(data) {
	for(i in data.task_list) {
		data.task_list[i].html_content = $('<div/>').text(data.task_list[i].content).html().replace("\n", "<br/>");
		data.task_list[i].deadline_time_till = "до " + data.task_list[i].deadline_time + " часов"
	}
	task_item = $("#task-list").html(
        $("#task-template").render(data.task_list)
    );
    $("#task-shadow").css('z-index', -1)
    	.animate({ opacity: 0 }, 400, 'easeOutCirc');
    $("#task-list")
    	.animate({ opacity: 1 }, 400, 'easeOutCirc');
	selectedTask = null;
    $(".task-area").click(task_select);
    init_task_actions($(task_item));
}

function task_select(event) {
	if (event.originalEvent.srcElement.nodeName == 'A')
		return;
	event.preventDefault();
	if (selectedTask == event.currentTarget)
		return;
	if (selectedTask)
		$(selectedTask).removeClass("selected");
	selectedTask = event.currentTarget;
	$(selectedTask).addClass("selected");
}

function init_task_actions(task) {
	task.find(".task-action-delegate").click(createSubTask);
}

function createSubTask(event) {
	event.preventDefault();

	var taskItem = $(event.currentTarget).parents('.task-area');
	var taskId = taskItem.data("task-id");
	console.log("ID = " + taskId);
	var parentDocumentId = taskItem.find('.task-document').data("id");
	console.log("ID = " + parentDocumentId);
	var content = taskItem.find('.task-content').data("value");
	var date = taskItem.find('.task-deadline-date').data("value");
	var time = taskItem.find('.task-deadline-time').data("value");

	var user_id = $('.user-info').data("value");
	var user_name = $('.user-name').data("value");

	var taskArea = $('.create-task-area');

	$('#Task-parent_task').data("id", taskId);
	$('#Task-parent_document').data("id", parentDocumentId);
	$('#Task-performer').val("").data("text", "").data("id", "");
	$('.performer-quick-list li').removeClass('pressed');
	$('#Task-co_performers').val("").data("text", "").data("id", "");
	$('#Task-informants').val("").data("text", "").data("id", "");
	$('#Task-controller').val(user_name).data("text", user_name).data("id", user_id);
	$('#Task-content').val(content);
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

	actors.reset();
	actors.set('controller');

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