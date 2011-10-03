

module("vector2")

test("Magnitude is correct", function() {
	equals(vector2({x: 1, y: 1}).magnitude(), Math.sqrt(2));
	equals(vector2({x: -2, y: 2}).magnitude(), Math.sqrt(8));
	equals(vector2({x: 10, y: -10}).magnitude(), Math.sqrt(200));
})

