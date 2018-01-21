# Instance Methods

#### empty
Checks if the stream is empty and returns a boolean value. This returns `false` for the empty stream and `true` for non-empty finite or infinite streams.

```js
var s = new Stream();
console.log( s.empty() ) // => true

var t = new Stream(10);
console.log( t.empty() ) // => false
```
---

#### head
Return the first item of the stream. It throws if it's called in empty streams.

```js
var t = new Stream(10);
console.log( t.head() ) // => 10

var s = new Stream();
console.log( s.head() ) // => Error: Cannot get the head of the empty stream.
```
---

#### tail
Return the original stream without the head value. It throws if it's called in empty streams.

```js
var s = Stream.make(10, 20, 30);

var t = s.tail();        // returns the stream that contains two items: 20 and 30
console.log( t.head() ); // => 20

var u = t.tail();        // returns the stream that contains one item: 30
console.log( u.head() ); // => 30

var v = u.tail();        // returns the empty stream
console.log( v.empty() ); // => true

var w = u.tail(); // => Error: Cannot get the tail of the empty stream.
```
---

#### item
|Parameter|Description|
|---|---|
|n| *required* - Index of an item.|

Returns the *n-th* item of the stream. It throws if it's called in empty streams. If the item does not exist in the stream, an error is thrown. Items of infinite streams can be accessed using this method.

```js
// Finite stream.
var s = Stream.make(10, 20, 30);
console.log( s.item(0) ); // => 10
console.log( s.item(1) ); // => 20
console.log( s.item(2) ); // => 30
console.log( s.item(1000) ); // => Error: Item index does not exist in stream.
console.log( s.item() ); // => Error: Item index does not exist in stream.

// Infinite stream.
var t = Stream.makeOnes();
console.log( s.item(12056) ); // => 1
```
---

#### length
Returns the length of a finite stream. This operation has undefined behavior for infinite streams.

```js
var s = Stream.make(10);
console.log( s.length() ) // => 10

var t = Steam.makeOnes(); // infinite stream
console.log( t.length() ) // hangs!
```
---

#### add
|Parameter|Description|
|---|---|
|t| *required* - A stream.|

Returns a new stream the elements of which are obtained by summing the current stream with the stream `t`. Infinite streams can be added. If there are extraneous items in one of the streams, the other stream is assumed to be filled up with zeros to be added.

```js
var s = Stream.range(1, 10); // 1, 2, ...10
var t = s.scale(2); // 2, 4, ...20
var addedTogether = s.add(t);

addedTogether.print(); // => 3, 6, 9, 12, 15, 18, 21, 24, 27, 30
```
---

#### append
|Parameter|Description|
|---|---|
|t| *required* - A stream.|

Creates a new stream whose items consist of the items of the current stream followed by the items of stream `t`. If the current stream is infinite, it returns the current stream. Appending an infinite stream to a finite stream produces an infinite stream.

```js
var s = Stream.make(1);
var t = Stream.make(2, 3);
var appendedStream = s.append(t);

appendedStream.print() // => 1, 2, 3
```
---

#### zip
|Parameter|Description|
|---|---|
|f(x, y)| *required* - A function. `x` is the current item of stream `t` and `y` is another stream.|
|t| *required* - A Stream. |

Zips the elements of two streams using function `f`. Returns a new stream. This new stream contains one item for each item of the current stream. The new items are produced by zipping an item from the current stream with an item from stream `t`. The zipping happens by applying function `f` between the items from these two streams. `f` is called with two stream items as a parameter: The first parameter given to it is an item from `t`, while the second parameter given to it is an item from the current stream. If there are extraneous items in either the current stream or stream `t` (i.e. if one stream has more items than the other), these are ignored. Infinite streams can be zipped.

```js
// Streams with identical size.
var s = Stream.make(4, 8, 12, 23, 5);
var t = Stream.make(2, 10, 5, 99, 100);
var biggestOfTwo = s.zip(Math.max, t);

biggestOfTwo.print() // => 4, 8, 12, 99, 100

// Streams with different size.
var u = Stream.make(4, 8, 12, 16, 20);
var w = Stream.make(1, 12, 42);
var biggestOfTwo2 = u.zip(Math.max, w);

biggestOfTwo2.print() // => 4, 8, 42, 16, 20
```
---

#### map
|Parameter|Description|
|---|---|
|f(x)| *required* - A function. `x` is the current item of the stream.|

Applies function `f` to each element of the current stream and returns a stream of the mapped values. Infinite streams can be mapped.

```js
function f (x) {
  return 2 * x;
}

var s = Stream.range(10, 15); // 10, 11, 12, 13, 14, 15
var doubled = s.map(f);
doubled.print(); // => 20, 22, 24, 26, 28, 30
```
---

#### concatmap
|Parameter|Description|
|---|---|
|f(x)| *required* - A function. `x` is the current item of the stream.|

Applies the function `f` to each element of the stream. Then concatenates all the resulting elements into one big stream which is returned. `f` is applied to each element and is expected to return a stream result.

```js
function f (x) {
  return Stream.make(x * 5, x * 10);
}

var s = Stream.make(2, 9);
var t = s.concatmap(f);

t.print() // => 10, 20, 45, 90
```
---

#### reduce
|Parameter|Description|
|---|---|
|aggregator(prior, current)| *required* - A function. `prior` is the previous item of the current stream and `current` the current item.|
|initial| *optional* - A value to be used as initial value in `aggregator`|

Aggregates the stream elements into a single value through function *aggregator*. This is known in other languages as a *fold* or the *reduce* operation in map/reduce. It applies the *aggregator* function in the currently aggregated value (which starts at *initial*) and a stream item to produce a new aggregated value. When all items have been aggregated, it returns the result. If the initial value is omitted, the first element of the stream is taken as the initial value and the fold is applied on the rest of the stream. In this case, the stream must be non-empty. Requires a finite stream.

```js
function aggregator(prior, current) {
  return prior + current;
}

var s = Stream.range(1, 20); // 1, 2, ...20
var summed = s.reduce(aggregator, 0);

console.log( summed ); // => 210
```
---

#### sum
Returns the sum of the items of the stream. Requires a finite stream.

```js
var s = Stream.range(1, 20); // 1, 2, ...20
var summed = s.sum();

console.log( summed ); // => 210
```
---

#### walk
|Parameter|Description|
|---|---|
|f(x)| *required* - A function. `x` is the current item of the stream.|

Walks the stream items by applying function `f` on them. Equivalent to a for loop over the stream, this forces eager evaluation on the stream. Requires a finite stream.

```js
// Calculate the sum of all items in the stream.
var sum = 0;
function f(x) {
  sum += x;
}

var s = Stream.make(10, 20, 30, 40);

s.walk(f);
console.log( sum ) // => 100
```
---

#### force
 Forces eager evaluation of the stream. All tails are evaluated until the end of the stream. Requires a finite stream.

```js
var s = Stream.make(10, 20, 30, 40);

s.force();
console.log( s.head() ); // => 10

s = s.tail();
s.force();
console.log( s.head() ); // => 20

s = s.tail();
s.force();
console.log( s.head() ); // => 30

s = s.tail();
s.force();
console.log( s.head() ); // => 40
```
---

#### scale
|Parameter|Description|
|---|---|
|factor| *required* - A value.|

Returns a new stream in which all items have been multiplied by the given `factor`.

```js
var s = Stream.range(1, 10); // 1, 2, ...10
var t = s.scale(2);

t.print(); // => 2, 4, 6, 8, 10, 12, 14, 16, 18, 20
```
---

#### filter
|Parameter|Description|
|---|---|
|f(x)| *required* - A filter function. `x` is the current item of the stream.|

Filters the stream items by function `f`. Returns a new stream with the filtered items. `f` takes a single stream item and returns true or false. Only items for which it returns true are kept. Infinite streams can be filtered.

```js
function f (x) {
  return x % 2;
}

var s = Stream.range(1, 10);
var t = s.filter(f);

t.print(); // => 1, 3, 5, 7, 9
```
---
