


var vector2 = function(spec) {
	var that = {};
	
	that.getX = function() {
		return spec.x;
	};
	that.getY = function() {
		return spec.y;
	};
	that.magnitude = function() {
		return Math.sqrt(spec.x * spec.x + spec.y * spec.y);
	}
	
	return that;
}
