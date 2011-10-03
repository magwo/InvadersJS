

module("vector2")

test("Magnitude is correct", function() {
	equals(vector2(1, 1).magnitude(), Math.sqrt(2));
	equals(vector2(-2, 2).magnitude(), Math.sqrt(8));
	equals(vector2(10, -10).magnitude(), Math.sqrt(200));
})

