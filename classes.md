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

We can make a field read-only by using the `let` keyword.

```
class Button
	let label: String = "Do no press"

actor Main
	new create(env: Env) =>
		let btn = Button
		btn.label = "Press me" // oh no! This will not compile.
```
Constructors are introduced using the keyword `new`.

```pony
class Color
	var name: String
	
	new blue() =>
		 name = "Blue"
	
	new create(name': String) =>
		name = name'
		
actor Main
	new create(env: Env) =>
		let c = Color.blue()
		env.out.print("The color is: " + c.name)
```
```
$ ./main
The color is: Blue
```

If no constructor is given; a default constructor with zero arguments called `create` is generated.

```pony
class Thing

actor Main
	new create(env: Env) =>
		let t = Thing.create()  // works!
```

Pony offers a shorthand for the `create` constructor.

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

We can set the reference capability of new instances by changing the constructor.

```pony
class Button
  var label: String

  new ref create_ref() => // ref is the default. Redundant here.
    label = "Do not press"
    
  new val create_val() => // 'val': make  instance immutable.
    label = "Do not press"

  // and so on ...
  
actor Main
  new create(env: Env) =>
    let b1: Button = Button.create_ref()
    b1.label = "Press me"  // works
    
    let b2: Button = Button.create_val()
    b2.label = "Press me" // Oh no! This will not compile.

```

Functions (aka. methods) are introduces with the keyword `fun`.

```pony
class Label
    var name: String = "Fragile"

    fun get_name(): String =>
        name

    fun ref set_name(name' : String): String =>
        name = name'

actor Main
    new create(env: Env) =>
        let lb = Label
        lb.set_name("Sturdy")
        let name = lb.get_name()
        env.out.print("Name is: " + name)
```