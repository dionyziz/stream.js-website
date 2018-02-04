# Beyond Infinity
Let's now start playing with infinity. Streams don't need to have a finite number of elements. For example, you can omit the second argument to `Stream.range(low, high)` and write `Stream.range(low)`; in that case, there is no upper bound, and so the stream contains all the natural numbers from low and up. You can also omit `low` and it defaults to `1`. In that case `Stream.range()` returns the stream of natural numbers.

## Does that require infinite memory/time/processing power?
No, it doesn't. That's the awesome part. You can run these things and they work really fast, like regular arrays. Here's an example that prints the numbers from `1` to `10`:

```js
var naturalNumbers = Stream.range(); // returns the stream containing all natural numbers from 1 and up
var oneToTen = naturalNumbers.take(10); // returns the stream containing the numbers 1...10
oneToTen.print();
```

## You are cheating!
Yes, I am. The point is that you can think of these structures as infinite, and this introduces a new programming paradigm that yields concise code that is easy to understand and closer to mathematics than usual imperative programming. The library itself is very short; it's thinking about these concepts that matters. Let's play with this a little more and construct the streams containing all even numbers and all odd numbers respectively.

```js
var naturalNumbers = Stream.range(); // naturalNumbers is now 1, 2, 3, ...

var evenNumbers = naturalNumbers.map(function (x) {
  return 2 * x; // evenNumbers is now 2, 4, 6, ...
});

var oddNumbers = naturalNumbers.filter(function (x) {
  return x % 2 != 0; // oddNumbers is now 1, 3, 5, ...
});

evenNumbers.take(3).print(); // => 2, 4, 6
oddNumbers.take(3).print(); // => 1, 3, 5
```

Cool, right? I kept my promise that streams are more powerful than arrays. Now, bear with me for a few more minutes and let's introduce a few more things about streams. You can make your own stream objects using `new Stream()` to create an empty stream, or `new Stream(head, functionReturningTail)` to create a non-empty stream. In case of a non-empty stream, the first parameter is the head of your desired stream, while the second parameter is a function returning the tail (a stream with all the rest of the elements), which could potentially be the empty stream. Confusing? Let's look at an example:

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

Too much trouble for nothing? You can always use `Stream.make(10, 20, 30)` to do this. But notice that this way we can construct our own infinite streams easily. Let's make a stream which is an endless series of ones:

```js
function ones() {
  // the first element of the stream of ones is 1
  // the rest of the elements of this stream are given by calling the function ones() (this same function!)
  return new Stream(1, ones);
}

var s = ones();    // now s contains 1, 1, 1, 1, ...
s.take(3).print(); // => 1, 1, 1
```

Notice that if you use `s.print()` on an infinite stream, it will print for ever, eventually running out of memory. Hence it's best to `s.take( n )` before you `s.print()`. Using `s.length()` on infinite streams is meaningless, so don't do it; it will cause an infinite loop (trying to find the end of an endless stream). But of course you can use `s.map(f)` and `s.filter(f)` on infinite streams. However, `s.walk(f)` will also not run properly on infinite streams. So those are some things to keep in mind; make sure you use `s.take(n)` if you want to take a finite part of an infinite stream.

Let's see if we can make something more interesting. Here's an alternative and interesting way to create the stream of natural numbers:

```js
function ones() {
  return new Stream(1, ones);
}

function naturalNumbers() {
  // the natural numbers are the stream whose first element is 1...
  // and the rest are the natural numbers all incremented by one
  // which is obtained by adding the stream of natural numbers...
  // 1, 2, 3, 4, 5, ...
  // to the infinite stream of ones...
  // 1, 1, 1, 1, 1, ...
  // yielding...
  // 2, 3, 4, 5, 6, ...
  // which indeed are the REST of the natural numbers after one
  return new Stream(1, function () {
      return ones().add(naturalNumbers());
  });
}
naturalNumbers().take(5).print(); // => 1, 2, 3, 4, 5
```

The careful reader will now observe the reason why the second parameter to `new Stream` is a function that returns the tail and not the tail itself. This way we can avoid infinite loops by postponing when the tail is evaluated.

Let's now turn to a little harder example. It's left as an exercise for the reader to figure out what the following piece of code does.

```js
function sieve(s) {
  var h = s.head();
  return new Stream(h, function () {
    return sieve(s.tail().filter(function(x) {
        return x % h != 0;
    }));
  });
}

sieve(Stream.range(2)).take(10).print();
```

Make sure you take some time to figure out what this does. Most programmers find it hard to understand unless they have a functional programming background, so don't feel bad if you don't get it immediately.

*Here's a hint*: Try to find what the head of the printed stream will be. And then try to find what the second element of the stream will be (the head of the tail); then the third element, and so forth. The name of the function may also help you.

If you really can't figure out what it does, just run it and see for yourself! It'll be easier to figure out *how it does* it then.
