Array.prototype.remove = function(val) {
    var index = this.indexOf(val);
    if (index >= 0) this.splice(index, 1);
    return this;
};

Array.prototype.last = function () {
	return this[this.length - 1];
}

Array.prototype.isEmpty = function () {
	return this.length == 0;
}