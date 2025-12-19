# Classes

Pony has **classes**.

```pony
class Town
```

Classes have fields.

```pony
class Town
	var population: U64
```

Fields can have default values.

```pony
class Town
	var population: U64 = 0
```

We can make a single field read-only by using the `let` keyword.

```pony
class Button
	let label: String = "Do no press"

actor Main
	new create(env: Env) =>
		let btn = Button
		btn.label = "Press me" // oh no! Will not compile.
```
Constructors are introduced using the keyword `new`.

```pony
class Color
  var name: String
  
  new blue() =>
    name = "Blue"
  
  new named(name': String) =>
    name = name'
		
actor Main
  new create(env: Env) =>
    let c1 = Color.blue()
    env.out.print("The color is: " + c1.name)

    let c2 = Color.named("Orange")
    env.out.print("The color is: " + c2.name)
```
```
$ ./main
The color is: Blue
The color is: Orange
```

If no constructor is given; a default constructor with zero arguments called `create` is generated.

```pony
class Thing

actor Main
	new create(env: Env) =>
		let t = Thing.create()  // works!
```

Pony offers a shorthand (sugar) for the `create` constructor.

```pony
let t = Town  // same as: Town.create()
```
```pony
let u = Town(17)  // same as: Town.create(1731)
```
```pony
let q = Town(32, "York")  // same as: Town.create(32, "York")
```
```pony
// and so on ...
```

A constructor can set the reference capability of a new instances.

```pony
class Button
  var label: String

  new ref create_ref() => // 'ref' is the default. Redundant here.
    label = "Do not press"

  new val create_val() => // 'val': make instance immutable.
    label = "Do not press"

  // and so on ...

actor Main
  new create(env: Env) =>
    let b1 = Button.create_ref()
    b1.label = "Press me"  // works

    let b2 = Button.create_val()
    b2.label = "Press me" // Oh no! Will not compile.
```

Functions (aka. methods) are introduces with the keyword `fun`.

```pony
class Person
  var name: String = "Lisa"

  fun get_name(): String =>
    name

  fun ref set_name(name' : String): String =>
    name = name'

actor Main
  new create(env: Env) =>
    let p = Person
    p.set_name("Bob")
    let name = p.get_name()
    env.out.print("Name is: " + name)
```
```
$ ./main
Name is: Bob
```
