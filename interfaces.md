# Interfaces

Interfaces are introduced with the keyword `interface`.

Interfaces can be used for both _structural_ and _nominal_ subtyping.

A concrete type is a member of a _structural_ category if it happens to have all the needed elements.

```pony
interface box Stringable
  """
  Things that can be turned into a String.
  """
  fun string(): String iso^
    """
    Generate a string representation of this object.
    """

primitive ExecveError
  fun string(): String iso^ => "ExecveError".clone() // Has string(): String iso^. So structurally `Stringable`
```

Nominal subtyping is introduces with the keyword `is`. 


```pony
interface Person
    fun name(): String => "Bob"

class Bob is Person  // Bob is Person because Bob says so.
```

