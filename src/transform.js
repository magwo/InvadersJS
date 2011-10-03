


var transform = function(spec) {
	var that = {};
	var pos = vector2(spec.x, spec.y);
	
	that.position = function() {
		return Object.create(pos);
	};
	
	return that;
}
