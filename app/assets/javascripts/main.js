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
	initTiles();
	layoutMainArea();
	$(window).resize(layoutMainArea);
	$('.task-info-item > div')
		.click(tileSelect);
	taskInfoGrid
		.click(toGrid);
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

	headerActions = $('.header-actions');
	headerActions
		.css('position', 'fixed');

	userControl = $('.user-control');
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
			width: tileWidth * 3 + tileSep * 3,
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
			width: width - tileSep,
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
		left: performBoxRect.left,
		top: performBoxRect.top - 5,
		width: performBoxRect.width * 0.6,
		height: 5
	});

	userControlRect = new Rect({
		right: width - performBoxRect.left - performBoxRect.width,
		top: performBoxRect.top - 4.5,
		width: performBoxRect.width * 0.4,
		height: 5
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
	event.preventDefault();
	if (collapsed) 
		return;

	var tileWidth = 240;
	var tileSep = 20;
	var left = 10;
	var top = 3.5;
	var topShift = 3.5;

	performBox
		.animate({ height: '24.5em', width: tileWidth + tileSep, left: 10, top: '6em' }, 400, 'easeOutCirc', function () { collapsed = true; });
	for(i in itemsToPerform)
	{
		itemsToPerform[i]
			.animate({ left: left, width: tileWidth, height: '3em', top: top + 'em'}, 400, 'easeOutCirc');
		itemsToPerform[i].children('.icon')
			.animate({ opacity: 0}, 400, 'easeOutCirc');
		itemsToPerform[i].children('.new')
			.animate({ bottom: '0.2em' }, 400, 'easeOutCirc');
		itemsToPerform[i].children('.header')
			.animate({ 'margin-right': '4em', 'margin-top': '-0.3em' }, 400, 'easeOutCirc');
		top += topShift;
	}		
	issuedBox
		.animate({ height: '14em', width: tileWidth + tileSep, left: 10, top: '31em' }, 400, 'easeOutCirc');
	var top = 3.5;
	for(i in itemsIssued)
	{
		itemsIssued[i]
			.animate({ left: left, width: tileWidth, height: '3em', top: top + 'em'}, 400, 'easeOutCirc');
		itemsIssued[i].children('.icon', 'easeOutCirc')
			.animate({ opacity: 0}, 400);
		itemsIssued[i].children('.new')
			.animate({ bottom: '0.2em' }, 400, 'easeOutCirc');
		itemsIssued[i].children('.header')
			.animate({ 'margin-right': '4em', 'margin-top': '-0.3em' }, 400, 'easeOutCirc');
		top += topShift;
	}
	headerActions
		.animate({ height: '4em', top: '0em', left: tileWidth + tileSep, width: 3 * tileWidth }, 400, 'easeOutCirc');
	userControl
		.animate({ height: '5em', top: '1.2em', right: '1em', width: tileWidth }, 400, 'easeOutCirc');
	taskInfoGrid
		.animate({ width: '4em', opacity: 1 }, 400, 'easeOutCirc');
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
		itemsToPerform[i].animateMoveToRect(itemRects[i], 400, 'easeOutCirc');
		itemsToPerform[i].children('.icon')
			.animate({ opacity: 1}, 400, 'easeInCirc');
		itemsToPerform[i].children('.new')
			.animate({ bottom: '0.5em' }, 400, 'easeOutCirc');
		itemsToPerform[i].children('.header')
			.animate({ 'margin-right': 'inherit', 'margin-top': 'inherit' }, 400, 'easeOutCirc');
	}		
	issuedBox
		.animateMoveToRect(issuedBoxRect, 400, 'easeOutCirc');
	for(i in itemsIssued)
	{
		itemsIssued[i]
			.animateMoveToRect(issuedRects[i], 400, 'easeOutCirc');
		itemsIssued[i].children('.icon')
			.animate({ opacity: 1}, 400, 'easeInCirc');
		itemsIssued[i].children('.new')
			.animate({ bottom: '0.5em' }, 400, 'easeOutCirc');
		itemsIssued[i].children('.header')
			.animate({ 'margin-right': 'inherit', 'margin-top': 'inherit' }, 400, 'easeOutCirc');
	}
	taskInfoGrid
		.animate({ width: '0em', opacity: 0}, 400, 'easeOutCirc');
	$('.data-area')
		.animate({ opacity:0 }, 400, 'easeOutCirc');
}