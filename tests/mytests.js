// Let's test this function  
function isEven(val) {
    return val % 2 === 0;  
}

function concatenate(s1, s2) {
	return s1 + s2;
}
  
test('isEven()', function() { 
    ok(isEven(0), 'Zero is an even number'); 
    ok(isEven(2), 'So is two'); 
    ok(isEven(-4), 'So is negative four'); 
    ok(!isEven(1), 'One is not an even number'); 
    ok(!isEven(-7), 'Neither is negative seven');  
})  


test("shouldConcatenate", function() {
	equals("string", concatenate("str", "ing"));
})
