Commands['get'] = lambda do |env, command, args|
  value = env.get(args.first)
  [Command::Success, Output.new(value), env]
end
