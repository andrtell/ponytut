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
Constructors are introduced using the keyword `new`.

```
class Color
	var name: String
	
	new create(name': String) =>
		name = name'
	
	new red() =>
		name = "Red"
	
	new green() =>
		name = "Green"
		
	new blue() =>
		name = "Blue"
		
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
		let t = Thing.create()  # works!
```

There is some sugar to invoke constructors named `create`.

```pony
let t = Town  // same as: Town.create()
```
```pony
let u = Town(17)  // same as: Town.create(1731)
```
```pony
let q = Town(32, "York")  // same as: Town.create(32, "York")
```
```
// and so on ...
```
