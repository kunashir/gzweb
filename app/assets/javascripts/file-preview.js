function FilePreview() {
	var area = $('.file-preview-area'),
		close = area.find('.actions .close'),
		frame = $('#file-preview-frame'),
		loadingLid = $('.file-preview-loading-lid'),
		open = false;

	function init() {
		close.click(closePreviewArea);
		if (frame.length > 0)
			frame[0].onload = attachFrameKeyhandler;
		area.keydown(onFrameKeyDown);
	}

	function attachFrameKeyhandler() {
		loadingLid.animate({opacity: 0}, 400, 'easeOutCirc', function() { loadingLid.css('display', 'none'); });
		$(frame[0].contentWindow.document.body).focus();
		$(frame[0].contentWindow.document).keydown(onFrameKeyDown);
	}

	function onFrameKeyDown(e) {
		if (e.keyCode == 8 || e.keyCode == 27) {
			closePreviewArea(e);
		}
	}

	function showPreviewArea() {
		if (open)
			return;
		area.css('opacity', 0).css('display', 'block');
		area.animate({opacity: 1}, 400, 'easeOutCirc', function () { 
			area.focus();
		});
		open = true;
	}

	function closePreviewArea(e) {
		e.preventDefault();
		if (!open)
			return;
		area.animate({opacity: 0}, 400, 'easeOutCirc', function () {
			area.css('display', 'none');
		})
		open = false;
	}

	this.openFile = function (file_id, file_name) {
		loadingLid.css('display', 'block').css('opacity', 1);
		frame.attr('src', '/web/viewer.html?file=/file_pdf/' + file_id);
		showPreviewArea();
	}

	init();
}

$(function () {
	window.filePreview = new FilePreview();
});