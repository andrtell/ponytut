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
    var x: Data ref = Data // ref^ -> ref

    // write
    x.n = 99

    // read
    if x.n > 1 then  
      env.out.print("works!")
    end

    // many aliases
    var y: Data ref = x // ref -> ref
    var z: Data box = x // ref -> box
    var t: Data tag = x // ref -> tag

```

`trn` can be written to and read from.
 
`trn` can be aliased by a `box` or `tag`. 

`trn` is _not_ sendable.

```pony
class Data
  var n: U64 = 1

actor Main
  new create(env: Env) =>
    var x: Data trn = Data // ref^ -> trn

    // write
    x.n = 99

    // read
    if x.n > 1 then
      env.out.print("works!")
    end

    // many read-only aliases
    var y: Data box = x // trn -> box
    var t: Data tag = x // trn -> tag
```

`iso` can be written to and read from.
 
`iso` can be aliased by a `tag`.

`iso` is _not_ sendable.

```pony
class Data
  var n: U64 = 1

actor Main
  new create(env: Env) =>
    var x: Data iso = Data // ref^ -> iso

    // write
    x.n = 99

    // read
    if x.n > 1 then
      env.out.print("works!")
    end

    // many opaque aliases
    var t: Data tag = x // iso -> tag
    var q: Data tag = x // iso -> tag
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
    var x: Data iso = Data // ref^ -> iso

    var a: Data ref = consume x // iso (-> iso^) -> ref (any RC will do)

    var y: Data iso = Data // ref^ -> iso

    Other.send(consume y) // iso (-> iso^) -> iso
```
