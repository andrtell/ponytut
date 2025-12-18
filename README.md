# Pony Tutorial

See:

[Ponylang.io](https://www.ponylang.io/) 

### Example 1

```
$ mkdir ex1 & cd ex1
```
```
// main.pony

actor Main
	new create(env: Env) =>
		None
```
```
$ ponyc 
```
```
$ ls -F
ex1*  main.pony
```
```
$ ./ex1
```
```
$ echo $?
0
```
Pony code is organised into **packages**. 

A package corresponds to a directory (i.e `ex1/`). 

Sub-directories are *NOT* are not included.

### Example 2

```
// main.pony

actor Main
	new create(env: Env) =>
		Blue.say(env)
		Red.say(env)
```
```
// blue.pony

primitive Blue
	fun say(env: Env) =>
		env.out.print("Blue")
```
```
// red.pony

primitive Red
	fun say(env: Env) =>
		env.out.print("Red")
```
```
$ ponyc 
```
```
$ ls -F
ex2*  main.pony blue.pony red.pony
```
```
$ ./ex2
Blue
Red
```

A package can be split into multiple source files, the compiler treats the package code as if it were from a *single* source file.

### Example 3
```
// main.pony

actor Main
	new create(env: Env) =>
		Blue.say(env)
		Red.say(env)

primitive Blue
	fun say(env: Env) =>
		env.out.print("Blue")

primitive Red
	fun say(env: Env) =>
		env.out.print("Red")
```
```
$ ponyc 
```
```
$ ls -F
ex3*  main.pony
```
```
$ ./ex3
Blue
Red
```
Same package as example 2.

### Example 4

```
$ mkdir -p ex4/p1
```
```
// p1/main.pony

actor Main
	new create(env: Env) =>
		None
```
```
$ ponyc -b runme p1/
```
```
$ ls -F
runme* p1/
```
```
$ ./runme
```
Compiling the package from outside the package directory and giving the binary a new name.

### Example 5

```
$ mkdir -p ex5/yellow ex5/red/tomato
```
```
// yellow/main.pony

use "tomato"

actor Main
	new create(env: Env) =>
		Tomato.say(env)
```

```
// red/tomato/tomato.pony

primitive Tomato
	fun say(env: Env) =>
		env.out.print("Tomato")
```

```
$ ponyc -b main --path red/ yellow/
```
```
$ ls -F
main* yellow/ red/
```
```
$ ./main
Tomato
```
 Given `use "tomato"` and the compiler flag `--path red/`  the compiler tries to find the package `tomato`  relative to the "package path" `red/` (i.e `red/tomato`)
 
 ### Example 6
 
 
 
 