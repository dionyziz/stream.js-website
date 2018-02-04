# Static Methods

#### cycle
|Parameter|Description|
|---|---|
|a| *required* - An array of elements.|

Returns an infinite stream by continually concatenating the array `a`.

```js
var s = Stream.cycle([98, 99, 100]);

console.log( s.item(0) ); // => 98
console.log( s.item(1) ); // => 99
console.log( s.item(2) ); // => 100
console.log( s.item(3) ); // => 98
console.log( s.item(4) ); // => 99
console.log( s.item(5) ); // => 100
```
---

#### equals
|Parameter|Description|
|---|---|
|s| *required* - A stream.|
|t| *required* - A stream.|

Checks if two streams are equal. Return `true` if they are equal or falsy value otherwise. Two streams are equal when they have the same number of elements and each two elements in the same positions are equal.

```js
var s = Stream.range(10, 20);
var t = Stream.range(10, 20);
var u = Stream.range(5, 60);

console.log( Stream.equals(s, t) ); // => true
console.log( Stream.equals(s, u) ); // => undefined
console.log( Stream.equals(t, u) ); // => undefined
```
---

#### fromArray
|Parameter|Description|
|---|---|
|array| *required* - Array of values to be used as elements in the stream.|

Returns a stream which contains the items from the specified array. The stream contains exactly *n* items where *n* is the number of elements in the array specified.

```js
var s = Stream.fromArray([5, 10, 15, 'George']);
s.print(); // => 5, 10, 15, George
```
---

#### iterate
|Parameter|Description|
|---|---|
|x| *required* - An initial value.|
|f(x)| *required* - A function. `x` is the previous item of stream.|

Returns an infinite stream with items calculated based on function `f`. `x` is the initial value of the stream that will be used to calculate all the others.

```js
function f (x) {
  return x * 2;
}

var powersOfTwo = Stream.iterate(1, f);

console.log( powersOfTwo.item(0) ); // => 1
console.log( powersOfTwo.item(1) ); // => 2
console.log( powersOfTwo.item(2) ); // => 4
console.log( powersOfTwo.item(10) ); // => 1024
console.log( powersOfTwo.item(369) ); // => 1.2024538023802026e+111
```
---

#### make
|Parameter|Description|
|---|---|
|a1, a2n ...an| *required* - Values to be used as elements in the stream.|

Returns a stream which contains the items specified in the function parameters. The stream contains exactly *n* items, where *n* is the number of arguments passed to the function.

```js
var s = Stream.make(5, 10, 15, 'George');
s.print(); // => 5, 10, 15, George
```
---

#### makeNaturalNumbers
Returns an infinite stream of natural numbers: 1, 2, 3, ...

```js
var s = Stream.makeNaturalNumbers();

console.log( s.item(0) ); // => 1
console.log( s.item(5) ); // => 6
console.log( s.item(1000) ); // => 1001
```
---

#### makeOnes
Returns an infinite stream filled with the number 1.

```js
var s = Stream.makeOnes();

console.log( s.item(0) ); // => 1
console.log( s.item(5) ); // => 1
console.log( s.item(1000) ); // => 1
```
---

#### range
|Parameter|Description|
|---|---|
|low| *optional* - A value that indicate the first stream element.|
|high| *optional* - Array of values to be used as elements in the stream.|

Returns a stream containing the integer numbers in the range [`low`, `high`]. The resulting stream contains exactly `high - low + 1` items. If low is omitted, it is assumed to be `1`. If `high` is omitted, an infinite range is produced, with no upper bound.

```js
var s = Stream.range(10, 20);
s.print(); // => 10, 11, ...20
```
---

#### repeat
|Parameter|Description|
|---|---|
|x| *required* - A value.|

Returns an infinite stream filled with `x`.

```js
var s = Stream.repeat('element');

console.log( s.item(0) ); // => element
console.log( s.item(5) ); // => element
console.log( s.item(1000) ); // => element
```
---
