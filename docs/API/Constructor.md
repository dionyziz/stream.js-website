# Constructor

> new Stream()

Create a new empty stream.

```js
var s = new Stream();

console.log( s.length() ) // => 0
```
---

> new Stream(head, tailPromise)

|Parameter|Description|
|---|---|
|head| *required* - The head (aka. the first element) of the stream.|
|tailPromise| *required* - Function returning the tail (a stream with all the rest of the elements), which could potentially be the empty stream.|

Create a new non-empty stream.

```js
// the head of the s stream is 10; the tail of the s stream is the empty stream
var s = new Stream(10, function () {
  return new Stream();
});
s.print(); // => 10

// the head of the t stream is 10; its tail has a head which is 20 and a tail which
// has a head which is 30 and a tail which is the empty stream.
var t = new Stream(10, function () {
  return new Stream(20, function () {
    return new Stream(30, function () {
      return new Stream();
    });
  });
});
t.print(); // => 10, 20, 30
```
