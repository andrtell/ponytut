# Primitives

Primitives are  types with no fields.

```pony
primitive Red
primitive Green
primitive Blue
```

A Primitive only ever have 1 instance (they are singeltons).

```pony
primitive Unicorn

actor Main
	new create(env: Env) =>
		if Unicorn.create() is Unicorn.create() then
			env.out.print("Same!")
		end
```
```
$ ./main
Same!
```

Primitives can have functions.

```pony
primitive Snowflake
	fun speak(env: Env) =>
		env.out.print("I am special!")
		
actor Main
	new create(env: Env) =>
		Snowflake.speak(env)  // No sugar: Snowflake.create().speak(env)
```
```
$ ./main 
I am special!
```

Type unions + Primitives = Enumerations.

```pony
type Color is (Red | Green | Blue)
```

Primitives can be used in `match` expressions.

```pony
primitive Yes
primitive No

type Answer is (Yes | No)

actor Main
	new create(env: Env) =>
		let answer: Answer = Yes
		let text = match answer
		| Yes => "Yes!"
		| No => "No!"
		end
		env.out.print("Answer is: " + text)
```
```
$ ./main
Answer is: Yes!
```
