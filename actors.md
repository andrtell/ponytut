# Actors

Actors are like classes, unlike classes, actors have behaviours that are introduced by the keyword `be`.

Behaviours can be called on a receiver of any reference capability.

Actors are sequential. The code within a single actor (instance) is never run concurrently. 

Behaviours are asynchronous and behaviours from diffrent agents (instances) run concurrently.

```pony
actor Store
    var value: U64 = 0

    be inc() =>
       value = value + 1 

    be print(env: Env) =>
        env.out.print(value.string())

actor Main
    new create(env: Env) =>
        let s = Store
        s.inc()
        s.print(env)
```
```
$ ./main
1
```
