# First Stream
Streams are containers. They contain items. You can make a stream with some items using `Stream.make()`. Just pass it as arguments the items you want to be part of your stream:

```js
var s = Stream.make(10, 20, 30); // s is now a stream containing 10, 20, and 30
```

Easy enough, `s` is now a stream containing three items: `10`, `20`, and `30`; in this order. We can look at the length of the stream using `s.length()` and retrieve particular items by index using `s.item(i)`. The first item of the stream can also be obtained by calling `s.head()`. Let's see it in action:

```js
var s = Stream.make(10, 20, 30);
console.log( s.length() ); // => 3
console.log( s.head() );   // => 10
console.log( s.item(0) );  // exactly equivalent to the line above
console.log( s.item(1) );  // => 20
console.log( s.item(2) );  // => 30
```

Continuing, the empty stream can be constructed either using `new Stream()` or just `Stream.make()`. The stream containing all the items of the original stream except the head can be obtained using `s.tail()`. Calling `s.head()` or `s.tail()` on an empty stream yields an error. You can check if a stream is empty using `s.empty()` which returns either `true` or `false`.

```js
var s = Stream.make(10, 20, 30);
var t = s.tail();        // returns the stream that contains two items: 20 and 30
console.log( t.head() ); // => 20
var u = t.tail();        // returns the stream that contains one item: 30
console.log( u.head() ); // => 30
var v = u.tail();        // returns the empty stream
console.log( v.empty() ); // => true
```

Here's a way to print all the elements in a stream:

```js
var s = Stream.make(10, 20, 30);
while (!s.empty()) {
  console.log( s.head() );
  s = s.tail();
}
```

There's a convenient shortcut for that: `s.print()` shows all the items in your stream.

---
**Continue to the [next section](./More_Goodies.md) to find out more about streams.**
