$(initDatepickers);

function initDatepickers() {
	$.datepicker.setDefaults({
		dateFormat: 'dd.mm.yyyy hh:MM',
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
	$(".date-picker").datepicker();
}

$(function () {
	$('.performer-quick-block .performer-image').css("background-size", "contain");
})

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
		$("<div></div>")
			.addClass('task-file')
			.text(fileInput.val().split('\\').pop())
			.appendTo(fileArea);

	    var file = fileInput[0].files[0];
	    var xhr = new XMLHttpRequest();
	    xhr.file = file; // not necessary if you create scopes like this
	    xhr.addEventListener('progress', function(e) {
	        var done = e.position || e.loaded, total = e.totalSize || e.total;
	        console.log('xhr progress: ' + (Math.floor(done/total*1000)/10) + '%');
	    }, false);
	    if ( xhr.upload ) {
	        xhr.upload.onprogress = function(e) {
	            var done = e.position || e.loaded, total = e.totalSize || e.total;
	            console.log('xhr.upload progress: ' + done + ' / ' + total + ' = ' + (Math.floor(done/total*1000)/10) + '%');
	        };
	    }
	    xhr.onreadystatechange = function(e) {
	        if ( 4 == this.readyState ) {
	            console.log(['xhr upload complete', e]);
	        }
	    };
	    xhr.open('post', url, true);
		var fd = new FormData;
		fd.append('file', file);
	    xhr.send(fd);
	}
}
