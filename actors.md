# Actors

Actors are like classes, unlike classes, actors have behaviours that are introduced by the keyword `be`.

Behaviours can be called on a receiver of any reference capability.

Actors are sequential. The code within a single actor (instance) is never run concurrently. 

Behaviours are asynchronous and behaviours from diffrent agents (instances) run concurrently.

```pony
actor A
  be send(env: Env, cnt: U64 val) =>
    env.out.print("A: " + cnt.string())
    send(env, cnt + 1)

actor B
  be send(env: Env, cnt: I64 val) =>
    env.out.print("B: " + cnt.string())
    send(env, cnt - 1)

actor Main
    new create(env: Env) =>
      A.send(env, 0)
      B.send(env, 0)
```
```
$ ./main
A: 0
B: 0
A: 1
A: 2
A: 3
B: -1
A: 4
A: 5
A: 6
B: -2
A: 7
B: -3
B: -4
<CTRL-C>
```
