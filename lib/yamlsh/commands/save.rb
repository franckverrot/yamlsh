Commands['save'] = lambda do |env, command, args|
  begin
    value = env.save
    [Command::Success, Output.new(value), env]
  rescue Yaml::Env::SaveError => e
    [Command::Error, Output.new("save: #{e.message}"), env] 
  end
end
