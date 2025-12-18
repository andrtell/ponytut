actor Main
  new create(env: Env) =>
    Blue.say(env)
    Red.say(env)
