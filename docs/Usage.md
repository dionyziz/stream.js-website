# Usage
In nodejs:

```js
var Stream = require('stream.js');
var s1 = Stream.make(1,2,3);
var s2 = new Stream();
s2.append(1).append(2).append(3);
```

In the browser:

```html
<script src="stream.js"></script>
<script>
  var s1 = Stream.make(1,2,3);
  var s2 = new Stream();
  s2.append(1).append(2).append(3);
</script>
```

or with AMD:
```js
define(function(require) {
  var Stream = require("stream.js");
  Stream.make(1,2,3).print();
});
```
