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

If the other package is not in a sub-directory of the compilation target package being compiled we need to tell `ponyc` how to find it.

```
$ mkdir -p vendor/somerepo/somepackage
```

```pony
// mypackage/main.pony

use "somepackage"

actor Main
	new create(env: Env) =>
		Some.say(env)
```

```pony
// vendor/somerepo/somepackage/some.pony

primitive Some
	fun say(env: Env) =>
		env.out.print("Hello from Some in somepackage")
```

```
$ ponyc -b main -p vendor/somerepo mypackage/
```
```
$ ./main
Hello from Some in somepackage
```
