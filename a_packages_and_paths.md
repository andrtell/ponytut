# My Pony Tutorial

## A. Packages and paths

Pony code is organised into **packages**. Each package corresponds to a directory (i.e `mypackage/`). 

```
$ mkdir mypackage
```
```pony
// mypackage/main.pony

actor Main
	new create(env: Env) =>
		None
```
```
$ ponyc -b main mypackage/
```
```
$ ls -F
main* mypackage/
```
```
$ ./main  # does not do anything
```
A package can be split into multiple source files. They are treated as a *single* source file.

```pony
// mypackage/main.pony

actor Main
	new create(env: Env) =>
		Extra.say(env)
```
```pony
// mypackage/extra.pony

primitive Extra
	fun say(env: Env) =>
		env.out.print("Extra says hi!")
```
```
$ ponyc -b main mypackage/
```
```
$ ./main
Extra says hi!
```
Other packages can be used by using the `use` statement.

```
$ mkdir -p mypackage/otherpackage
```

```pony
// mypackage/main.pony

use "otherpackage"

actor Main
	new create(env: Env) =>
		Other.say(env)
```

```pony
// mypackage/otherpackage/other.pony

primitive Other
	fun say(env: Env) =>
		env.out.print("Hello from Other in otherpackage")
```

```
$ ponyc -b main mypackage/
```
```
$ ./main
Hello from Other in otherpackage
```

 Given `use "tomato"` and the compiler flag `--path red/`  the compiler tries to find the package `tomato`  relative to the "package path" `red/` (i.e `red/tomato`)
 
### Example 6
 
```
$ mkdir -p ex6/one/two/three
```
```
// one/main.pony

use "two"
use "two/three"

actor Main
	new create(env: Env) =>
		A.say(env)
		B.say(env)		 
```

```
// one/two/a.pony

primitive A
	fun say(env: Env) =>
		env.out.print("Two.A")
```

```
// one/two/three/b.pony

primitive B
	fun say(env: Env) =>
		env.out.print("Three.B")
```
```
$ ponyc -b main one/
```
```
$ ls -F
main* one/
```
```
$ ./main
Two.A
Three.B
```

The target package (`one/`) is always on the path. The packages `two` and `three` can be found without adding anything to the pony path. Note `use "two/three"` here.
 
