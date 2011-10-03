

module("transform");

test('Should store position from spec', function() {
	var t = transform({x: 2.0, y: 5.0});
	equals(t.position().getX(), 2.0);
	equals(t.position().getY(), 5.0);
})

test("Does not expose position object", function() {
	var t = transform({x: 2.0, y: 5.0});
	var pos = t.position();
	pos.getX = function() { return -1.0; }
	equals(pos.getX(), -1.0);
	equals(t.position().getX(), 2.0);
})


test("Modified spec does not modify transform", function() {
	var spec = {x: 5, y: 8};
	var t = transform(spec);
	spec.x = 10;
	equals(t.position().getX(), 5);
})
