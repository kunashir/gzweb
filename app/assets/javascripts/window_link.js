function initWindowLinks() {
	$('.window-link').click(openLinkInAWindow);
}

function openLinkInAWindow(e) {
	e.preventDefault();
	var href = $(e.currentTarget).attr('href');
	window.open(href, '', 'fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no');
}

$(initWindowLinks);

