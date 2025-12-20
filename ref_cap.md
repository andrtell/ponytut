# Reference capability

1) Isolated data + Immutable data = concurrent programs without locks.

2) Type qualifier(s) + Variable(s) = Reference capabilities.

3) The Pony compiler ensures 1) by using 2).

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
