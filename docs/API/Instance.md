# Instance Methods

#### empty
Check whether a stream is empty or not.

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
var s = new Stream();
console.log( s.head() ) // => Error: Cannot get the head of the empty stream.

var t = new Stream(10);
console.log( t.head() ) // => 10
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

Retrieve a stream item by index. It throws if index is out of range.

```js
var s = Stream.make(10, 20, 30);
console.log( s.item(0) ); // => 10
console.log( s.item(1) ); // => 20
console.log( s.item(2) ); // => 30
console.log( s.item(1000) ); // => Error: Item index does not exist in stream.
console.log( s.item() ); // => Error: Item index does not exist in stream.
```
---

### length
Returns the length of the stream. The length can be calculated only in finite streams.

```js
var t = Stream.make(10);
console.log( t.length() ) // => 10

var s = Steam.makeOnes(); // infinite stream
console.log( s.length() ) // hangs!
```
---


