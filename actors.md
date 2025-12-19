# Actors

Actors have behaviours and are introduced by the keyword `be`.

When you call a behavior on an actor, you are sending it a message.

Behaviours can be called on a receiver of any reference capability.

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

Behaviours are asynchronous, you can run many behaviours at the same time. 

Actors themselves, however, are sequential.

This means all the code in an actor can be written without caring about concurrency.

```pony
actor Numbers
    be zero(env: Env) =>
      one(env) // returns None, guaranteed to run (sometime) after zero() is done.
      env.out.print("Zero")

    be one(env: Env) =>
      env.out.print("1")

actor Main
    new create(env: Env) =>
      Numbers.zero(env)
```
```
$ ./main
Zero
1
```
