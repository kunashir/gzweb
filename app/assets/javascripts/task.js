$(initDatepickers);

function initDatepickers() {
	$.datepicker.setDefaults({
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		dayNames: ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'],
		dayNamesMin: ['В', 'П', 'В', 'С', 'Ч', 'П', 'С'],
		dayNamesShort: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
		monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
		monthNamesShort: ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
		buttonImage: '/assets/calendar.png',
		buttonImageOnly: 1,
		showOn: 'none',
		duration: 'fast'
	});
	var input = $('input.date-picker');
	var selector = $('div.date-picker');
	selector.addClass('unset');
	selector.datepicker({
		onSelect: function(dateText) {
			if (!input.data("hour")) {
				input.data("hour", "18");
			}
			if (!input.data("minute")) {
				input.data("minute", "00");
			}
			input.data("date", dateText);
			input.val(dateText + " " + input.data("hour") + ":" + input.data("minute"));
			selector.removeClass('unset');
		}
	});
	var dateRegex = new RegExp("^\\s*(\\d{1,2})\\s*[\\.\\/]\\s*(\\d{1,2})\\s*([\\.\\/]\\s*(\\d{1,4})\\s*)?\\s*(\\s+(\\d{1,2})\\s*(:\\s*(\\d{1,2}))?)?\\s*$");
	input.keyup(function () {
		if (input.val().trim().length == 0)
		{
			var date = new Date();
			selector.datepicker('setDate', date.getDate() + "." + (date.getMonth() + 1) + "." + date.getFullYear());
			selector.addClass('unset');
			return;
		}
		var regMatch = dateRegex.exec(input.val());
		if (regMatch) {
			var day = +regMatch[1];
			var month = +regMatch[2];
			var year = new Date().getFullYear();
			if (regMatch[4]) {
				if (("" + year).substring(0, regMatch[4].length) != regMatch[4])
				{
					if (regMatch[4].length == 3)
						regMatch[4] += "0";
					year = +regMatch[4];
					if (year < 100)
						year += 2000;
				}
			}
			var hour = +(input.data("hour") || "18");
			if (regMatch[6])
				hour = +regMatch[6];
			var minute = +(input.data("minute") || "00");
			if (regMatch[8])
				minute = +regMatch[8];
			var date = new Date(year, month - 1, day, hour, minute);
			if (date.getMinutes() == minute && 
				date.getHours() == hour && 
				date.getDate() == day && 
				date.getMonth() == (month - 1) &&
				date.getFullYear() == year) {
				selector.datepicker('setDate', day + "." + month + "." + year);
				selector.removeClass('unset');
			}
		}
	});
	input.blur(function () {
		if (input.val().trim().length == 0)
		{
			var date = new Date();
			selector.datepicker('setDate', date.getDate() + "." + (date.getMonth() + 1) + "." + date.getFullYear());
			selector.addClass('unset');
			return;
		}
		var regMatch = dateRegex.exec(input.val());
		if (regMatch) {
			var day = +regMatch[1];
			var month = +regMatch[2];
			var year = new Date().getFullYear();
			if (regMatch[4]) {
				if (("" + year).substring(0, regMatch[4].length) != regMatch[4])
				{
					if (regMatch[4].length == 3)
						regMatch[4] += "0";
					year = +regMatch[4];
					if (year < 100)
						year += 2000;
				}
			}
			var hour = +(input.data("hour") || "18");
			if (regMatch[6])
				hour = +regMatch[6];
			var minute = +(input.data("minute") || "00");
			if (regMatch[8])
				minute = +regMatch[8];
			var date = new Date(year, month - 1, day, hour, minute);
			if (date.getMinutes() == minute && 
				date.getHours() == hour && 
				date.getDate() == day && 
				date.getMonth() == (month - 1) &&
				date.getFullYear() == year) {
				input.data("date", lead_zeros("" + day, 2) + "." + lead_zeros("" + month, 2) + "." + year);
				input.data("hour", lead_zeros("" + hour, 2));
				input.data("minute", lead_zeros("" + minute, 2));
			}
		}
		if (!input.data("date")) {
			var now = new Date();
			input.data("date", lead_zeros("" + now.getDate(), 2) + "." + lead_zeros("" + (now.getMonth() + 1), 2) + "." + lead_zeros("" + now.getFullYear(), 2));
		}
		if (!input.data("hour")) {
			input.data("hour", "18");
		}
		if (!input.data("minute")) {
			input.data("minute", "00");
		}
		selector.datepicker('setDate', input.data("date"));
		selector.removeClass('unset');
		input.val(input.data("date") + " " + input.data("hour") + ":" + input.data("minute"));
	});

	function lead_zeros(str, len) {
		var result = str;
		for (var i = 0; i < len - str.length; i++)
			result = "0" + result;
		return result;
	}
}


$(function () {
	$('.performer-quick-block .performer-image').css("background-size", "contain");
	$('.performer-quick-list li').click(selectQuickPerformer);
	lookupHandlers.select(onPerformerSelected);
})

function selectQuickPerformer(e) {
	e.preventDefault();
	$('.performer-quick-list li').removeClass('pressed');
	var container = $(e.currentTarget);
	container.addClass('pressed');
	var performer = container.children('.performer-quick-block');
	$('#Task-performer').data("text", performer.data("text"));
	$('#Task-performer').data("id", performer.data("id"));
	$('#Task-performer').val(performer.data("text"));
}

function onPerformerSelected(element) {
	if (element.id != 'Task-performer')
		return;
	var selectedID = $(element).data("id");
	var current = $('.performer-quick-list li.pressed');
	if (current != null && selectedID != current.data("id"))
		current.removeClass("pressed");
	var allQuickPerformers = $('.performer-quick-list li');
	console.log(selectedID);
	for (var i = 0; i < allQuickPerformers.length; i++)
	{
		var container = $(allQuickPerformers[i]);
		var quickID = container.children('.performer-quick-block').data("id");
		if (quickID == selectedID)
			container.addClass("pressed");
	}
}

function TaskActors() {
	this.actors = [
	{ 
		checkbox: $('.co_performers-selector'),
		input: $('.co_performers-row')
	},
	{ 
		checkbox: $('.informants-selector'),
		input: $('.informants-row')
	},
	{ 
		checkbox: $('.controller-selector'),
		input: $('.controller-row')
	}];

	this.init = function () {
		var $this = this;
		$this.actors.forEach(function (actor) {
			actor.checkbox.change(function (e) {
				e.preventDefault();
				$this.updateInputs();
			})
		});
		$this.updateInputs();
	}

	this.updateInputs = function () {
		this.actors.forEach(function (actor) {
			actor.input.css('display', actor.checkbox.prop("checked") ? "table-row" : "none");
		});
	}

	this.init();
}

$(function () {
	actors = new TaskActors();
	taskActions = new TaskActions();
	taskFiles = new TaskFiles();
});

function TaskActions() {
	var $this = this;

	$('.task-cancel').click(function (e) {
		e.preventDefault();
		$this.closeHandler();
	})

	$('.task-send').click(function (e) {
		e.preventDefault();
		var taskData = {
			performer: $('#Task-performer').data('id'),
			controler: $('#Task-controller').data('id'),
			content: $('#Task-content').val()
		};
		var date = $('input.date-picker');
		if (date.val().trim().length > 0)
 			taskData.deadline = date.data("date") + " " + date.data("hour") + ":" + date.data("minute");
 		taskData.files = $('.task-files .task-file').map(function (i, file) { return $(file).data("id"); }).toArray();
 		$.post('/tasks.json', taskData);
	})

	this.closeHandler = function () {
	}
}

function TaskFiles() {
	var $this = this,
		fileArea = $('.task-files'), 
		fileInput = fileArea.children('input'),
		fileAddButton = fileArea.children('.task-add-file'),
		url = "/file"

	fileAddButton.click(selectFile);
	fileInput.on("change", addFileToUpload);

	function selectFile(e) {
		e.preventDefault();
		var evt = document.createEvent("MouseEvents");
		evt.initEvent("click", true, false)
		fileInput[0].dispatchEvent(evt);
	}


	function addFileToUpload() {
		var re = /(?:\.([^.]+))?$/;
		var fileName = fileInput.val().split('\\').pop();
		$.get(
			"/file/icon?ext=" + re.exec(fileName)[1],
			function (data) {
				var taskFileDiv = $("<div></div>")
					.addClass('task-file');
				$("<img></img>")
					.addClass('task-file-icon')
					.attr('src', data.icon)
					.appendTo(taskFileDiv);
				var taskFileNameContainer = $("<div></div>")
					.addClass('task-file-name-container')
					.appendTo(taskFileDiv);
				$("<div></div>")
					.addClass('task-file-name')
					.text(fileName)
					.appendTo(taskFileNameContainer);
				var taskFileProgress = $("<div></div>")
					.addClass('task-file-progress')
					.appendTo(taskFileNameContainer);
				taskFileDiv.appendTo(fileArea);
				uploadFile(taskFileDiv, taskFileProgress);
			});
	}

	function uploadFile(fileDiv, progressBar) {
	    var file = fileInput[0].files[0];
	    var xhr = new XMLHttpRequest();
	    xhr.file = file; // not necessary if you create scopes like this
	    xhr.addEventListener('progress', function(e) {
	        var done = e.position || e.loaded, total = e.totalSize || e.total;
	        progressBar.css('width', (Math.floor(done/total*1000)/10) + '%');
	    }, false);
	    if ( xhr.upload ) {
	        xhr.upload.onprogress = function(e) {
	            var done = e.position || e.loaded, total = e.totalSize || e.total;
		        progressBar.css('width', (Math.floor(done/total*1000)/10) + '%');
	        };
	    }
	    xhr.onreadystatechange = function(e) {
	        if ( 4 == this.readyState ) {
	        	progressBar.css('background-color', 'green');
	        	var result = JSON.parse(this.response);
	        	fileDiv.data("id", result["id"]);
	        }
	    };
	    xhr.open('post', url, true);
		var fd = new FormData;
		fd.append('file', file);
	    xhr.send(fd);
	}
}
