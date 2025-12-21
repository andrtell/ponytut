# Reference capability (RC)

1) Isolated data + Immutable data = concurrent programs without locks.

2) Type qualifier(s) + Variable(s) = Reference capabilities.

3) The Pony compiler ensures 1) by using 2).

## Mutable reference capabilities

`ref` can be written to and read from.
 
`ref` can be aliased by a `ref`, `box` or `tag`. 

`ref` is _not_ sendable.

```pony
class Data
  var n: U64 = 1

actor Main
  new create(env: Env) =>
    var x: Data ref = Data // ref <- ref^ <- constructor (defaults to ref^ for class)

    // write
    x.n = 99

    // read
    if x.n > 1 then  
      env.out.print("works!")
    end

    // aliases
    var y: Data ref = x // ref <- ref
    var z: Data box = x // box <- ref
    var t: Data tag = x // tag <- ref

```

`trn` can be written to and read from.
 
`trn` can be aliased by a `box` or `tag`. 

`trn` is _not_ sendable.

```pony
class Data
  var n: U64 = 1

actor Main
  new create(env: Env) =>
    var x: Data trn = Data // trn <- ref^ <- constructor (defaults to ref^ for class)

    // write
    x.n = 99

    // read
    if x.n > 1 then
      env.out.print("works!")
    end

    // only read aliases
    var y: Data box = x // box <- trn
    var t: Data tag = x // tag <- trn
```

`iso` can be written to and read from.
 
`iso` can be aliased by a `tag`.

`iso` is _not_ sendable.

```pony
class Data
  var n: U64 = 1

actor Main
  new create(env: Env) =>
    var x: Data iso = Data // iso <- ref^ <- constructor (defaults to ref^ for class)

    // write
    x.n = 99

    // read
    if x.n > 1 then
      env.out.print("works!")
    end

    // only opaque aliases
    var t: Data tag = x // tag <- iso
    var q: Data tag = x // tag <- iso
```

`iso^` can be aliased by any RC.

`iso^` _is_ sendable.

```pony
class Data
  var n: U64 = 1

actor Other
  be send(q: Data iso) =>
    q.n = 2

actor Main
  new create(env: Env) =>
    var x: Data iso = Data // iso <- ref^ <- constructor (defaults to ref^ for class)

    var a: Data ref = consume x // ref <- iso^ <- consume iso

    var y: Data iso = Data

    Other.send(y = Data) // iso <- iso^ <- destructive read (old y passed)
```
