# Traits

Traits are introduced with the `trait` keyword.

Traits are used for _nominal_ subtyping.

```pony
class Name is Stringable
```

Traits can have default function implementations.

```pony
class Person
    fun name(): String => "Bob"

class Bob is Person // Bob is Person because Bob says so.

actor Main
    new create(env: Env) =>
        env.out.print(Bob.name())
```
```
$ ./main
Bob
```

A class can _provide_ more than one trait.

```pony
trait Person
    fun name(): String => "Bob"

trait Gamer
    fun screen_name(): String => "L33T"

class Bob is (Person & Gamer)

actor Main
  new create(env: Env) =>
    env.out.print(Bob.screen_name() + " - " + Bob.name())
```
```
$ ./main
L33T - Bob
```
