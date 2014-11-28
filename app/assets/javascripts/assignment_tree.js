function AssignmentTree(node) {
	var container = node,
	    splitterDownPos = null,
	    startWd = null,
	    leftPanel = container.find('.assignment-tree-tree-container'),
		splitter = container.find('.assignment-tree-panel-div'),
		rightPanel = container.find('.assignment-tree-details-container'),
		details = container.find('.assignment-tree-details'),
		treeArea = container.find('.assignment-tree'),
		selectedNode = null,
		treeHidingLid = container.find('.assignment-tree-hiding-lid'),
		detailsHidingLid = container.find('.assignment-tree-details-hiding-lid'),
		$this = this;

	$.templates("assignmentTreeTmpl", {markup: "#assignment-tree-template", allowCode: true })
	$.templates("assignmentDetailsTmpl", {markup: "#assignment-details-template", allowCode: true })

	initSlider();

	$this.load = function (id) {
		treeArea.html("");
		clearDetails();
		treeHidingLid.css('opacity', 0).css('display', 'block').animate({opacity: 1}, 200, 'easeOutCirc');
		$.get('/task_info/' + id + '/assignment_tree.json')
			.done(setAssignmentTree)
			.fail(setAssignmentTree)
	}

	function setAssignmentTree(data) {
		$($.render.assignmentTreeTmpl(data.tree)).appendTo(treeArea);
		treeHidingLid.animate({opacity: 0}, 200, 'easeOutCirc', function () {
			treeHidingLid.css('display', 'none');
		});
		initTreeSigns();
		initNodes();
	}

	function initSlider() {
		container.mousedown(function (e) {
			var x =  e.pageX - container[0].getBoundingClientRect().left
			var leftPanelWidth = leftPanel.width();
			if (x < leftPanelWidth - 5 || x > leftPanelWidth + 5)
				return;
			startWd = leftPanelWidth;
			splitterDownPos = x;
		});

		container.mouseup(function (e) {
			splitterDownPos = null;
		});

		container.mouseleave(function (e) {
			splitterDownPos = null;
		});

		container.mousemove(function (e) {
			if (!splitterDownPos)
				return;
			var x =  e.pageX - container[0].getBoundingClientRect().left
			var change = x - splitterDownPos;
			var total = container.width();
			var newP = (startWd + change) / total;
			if (newP < 0.1)
				newP = 0.1;
			if (newP > 0.9)
				newP = 0.9;
			leftPanel.css('width', newP * 100 + "%");
			splitter.css('left', newP * 100 + "%");
			rightPanel.css('left', newP * 100 + "%");
		});
	}

	function initTreeSigns() {
		var treeSigns = container.find('.tree-sign');

		for (var i = 0; i < treeSigns.length; i++) {
			if ($(treeSigns[i]).closest('.assignment-tree-node').find('ul').length > 0)
				$(treeSigns[i]).addClass('expanded');
		}

		treeSigns.click(function (e) {
			toggleNode($(e.currentTarget).closest('.assignment-tree-node'));
		});

		var texts = container.find('.title .text');

		texts.dblclick(function (e) {
			toggleNode($(e.currentTarget).closest('.assignment-tree-node'));
		});

		function toggleNode(node) {
			var sign = node.find('.tree-sign').first();
			var list = node.find('ul');
			if (sign.hasClass('expanded')) {
				sign.removeClass('expanded').addClass('collapsed');
				list.css('display', 'none');
				return;
			}
			if (sign.hasClass('collapsed')) {
				sign.removeClass('collapsed').addClass('expanded');
				list.css('display', 'block');
				return;
			}
		}
 	}

 	function initNodes() {
 		container.find('.text').click(function (e) {
 			setSelectedNode($(e.currentTarget).closest('.assignment-tree-node'));
 		})
 	}

 	function setSelectedNode(node) {
 		if (selectedNode)
 			selectedNode.removeClass('selected');
 		selectedNode = node;
 		if (selectedNode) {
 			selectedNode.addClass('selected');
 			loadDetails(selectedNode.data('assignment-id'), selectedNode.data('wftask-id'));
 		}
 		else {
 			clearDetails();
 		}
 	}

 	function loadDetails(assignmentID, wfTaskID) {
 		if (!assignmentID && !wfTaskID) {
 			clearDetails();
 			return;
 		}
 		detailsHidingLid.css('opacity', 0).css('display', 'block').animate({opacity: 1}, 200, 'easeOutCirc');
 		if (assignmentID)
 			loadAssignmentDetails(assignmentID);
 	}

 	function clearDetails() {
 		details.html("");
 	}

 	function loadAssignmentDetails(id) {
		$.get('/assignments/' + id + '/details.json')
			.done(setAssignmentDetails)
			.fail(setAssignmentDetails)
	}

	function setAssignmentDetails(data) {
		var detailsContent = $($.render.assignmentDetailsTmpl(data));
		details.html("");
		detailsContent.appendTo(details);
		detailsHidingLid.animate({opacity: 0}, 200, 'easeOutCirc', function () {
			detailsHidingLid.css('display', 'none');
		});
	}
}

function TaskAssignmentTree(node) {
	var root = node,
		tree = new AssignmentTree(root.find('.assignment-tree-panel')),
		closeBtn = root.find('.header .close'),
		$this = this;

	closeBtn.click(function (e) {
		e.preventDefault();
		root.animate({ opacity: 0}, 200, 'easeOutCirc', function () {
			root.css('display', 'none');
		});
	})

	$this.show = function (id) {
		root.css('opacity', 0).css('display', 'block').animate({opacity: 1}, 200, 'easeOutCirc');
		tree.load(id);
	}
}