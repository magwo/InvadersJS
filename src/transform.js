


var transform = function(spec) {
	var that = {};
	var pos = vector2({x: spec.x, y: spec.y});
	
	that.position = function() {
		return Object.create(pos) // Really need to clone object here for return-by-value?
	};
	
	return that;
}
