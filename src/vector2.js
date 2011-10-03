


var vector2 = function(x, y) {
	var that = {};
	
	that.getX = function() {
		return x;
	};

	that.getY = function() {
		return y;
	};

	that.magnitude = function() {
		return Math.sqrt(x * x + y * y);
	}

	that.magnitudeSqrd = function() {
		return x * x + y * y; 
	}
	
	return that;
}
