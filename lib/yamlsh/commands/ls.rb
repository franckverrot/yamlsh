Commands['ls'] = lambda do |env, command, args|
  output = env.keys.map do |key|
    key
  end.join("\n")
  [Command::Success, Output.new(output), env]
end
