# Reference capability

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
    var x: Data ref = Data // ref^

    x.n = 99  // written to

    if x.n > 1 then  // read from
      env.out.print("works!")
    end

    var y: Data ref = x // aliased
    var z: Data box = x
    var t: Data tag = x 

```

`trn` can be written to and read from.
 
`trn` can be aliased by a `box` or `tag`. 

`trn` is _not_ sendable.

```pony
class Data
  var n: U64 = 1

actor Main
  new create(env: Env) =>
    var x: Data trn = Data // ref^

    x.n = 99  // written to

    if x.n > 1 then  // read from
      env.out.print("works!")
    end

    var y: Data box = x // aliased
    var t: Data tag = x
```

`iso` can be written to and read from.
 
`iso` can be aliased by a `tag`.

`iso` is _not_ sendable.

```pony
class Data
  var n: U64 = 1

actor Main
  new create(env: Env) =>
    var x: Data iso = Data // ref^

    x.n = 99  // written to

    if x.n > 1 then  // read from
      env.out.print("works!")
    end

    var t: Data tag = x // aliased
```








```pony
actor A
  be send(env: Env, cnt: U64 val) =>
    env.out.print("A: " + cnt.string())
    send(env, cnt + 1)

actor Main
    new create(env: Env) =>
      A.send(env, 1)
```

```pony
class V
  var i: U64

  new create(i': U64) =>
    i = i'

actor B
  be send(env: Env, v: V val) =>
    env.out.print("B: " + v.i.string())
    send(env, V(v.i + 1))

actor Main
  new create(env: Env) =>
    B.send(env, V(0))
```

```pony
class V
  var i: U64

  new create(i': U64) =>
    i = i'

actor C
  be send(env: Env, v: V iso) =>
    env.out.print("C: " + v.i.string())
    v.i = v.i + 1
    send(env, consume v)

actor Main
  new create(env: Env) =>
    let v: V iso = V(0)
    C.send(env, consume v)
```
