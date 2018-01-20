# More Goodies
One of the useful shortcuts is the `Stream.range(min, max)` function. It returns a stream with the natural numbers ranging from `min` to `max` inclusive.

```js
var s = Stream.range(10, 20);
s.print(); // prints the numbers from 10 to 20
```

You can use `map`, `filter`, and `walk` on your streams.

`s.map(f)` takes an argument `f`, a function, and runs `f` on every element of the stream; it returns the stream of the return values of that function. So you can use it to, for example, double the numbers in your stream:

```js
function doubleNumber(x) {
  return 2 * x;
}

var numbers = Stream.range(10, 15);
numbers.print(); // prints 10, 11, 12, 13, 14, 15
var doubles = numbers.map(doubleNumber);
doubles.print(); // prints 20, 22, 24, 26, 28, 30
```

Cool, right? Similarly `s.filter(f)` takes an argument `f`, a function, and runs `f` on every element of the stream; it then returns the stream containing only the elements for which `f` returned true. So you can use it to only keep certain elements in your stream. Let's construct a stream keeping only the odd numbers of an original stream using this idea:

```js
function checkIfOdd(x) {
  if (x % 2 == 0) {
    // even number
    return false;
  } else {
    // odd number
    return true;
  }
}
var numbers = Stream.range(10, 15);
numbers.print(); // => 10, 11, 12, 13, 14, 15
var onlyOdds = numbers.filter(checkIfOdd);
onlyOdds.print(); // => 11, 13, 15
```

Useful, yes? Finally `s.walk(f)` takes an argument `f`, a function, and runs `f` on every element of the stream, but it doesn't affect the stream in any way. Here's another way to print the elements of stream:

```js
function printItem(x) {
  console.log( 'The element is: ' + x );
}
var numbers = Stream.range(10, 12);

numbers.walk(printItem);
// => The element is: 10
// => The element is: 11
// => The element is: 12
```

One more useful function: `s.take(n)` returns a stream with the first `n` elements of your original stream. That's useful for slicing streams:

```js
var numbers = Stream.range(10, 100); // numbers 10...100
var fewerNumbers = numbers.take(10); // numbers 10...19
fewerNumbers.print();
```

A few other useful things: `s.scale(factor)` multiplies every element of your stream by `factor`; and `s.add(t)` adds each element of the stream `s` to each element of the stream `t` and returns the result. Let's see an example of this:

```js
var numbers = Stream.range(1, 3);
var multiplesOfTen = numbers.scale(10);
multiplesOfTen.print(); // prints 10, 20, 30
numbers.add(multiplesOfTen).print(); // prints 11, 22, 33
```

Although we've only seen streams of numbers until now, you can also have streams of anything: strings, booleans, functions, objects; even arrays or other streams. Please note however that your streams may not contain the special value `undefined` as an item.

---
**Continue to the [next section](./Beyond_Infinity.md) and start playing with `infinity`.**
