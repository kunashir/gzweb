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
		$this = this;
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
});