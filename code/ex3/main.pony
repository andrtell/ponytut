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
