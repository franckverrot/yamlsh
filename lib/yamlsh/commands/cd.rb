Commands['cd'] = lambda do |env, command, args|
  begin
    env.cd(args.first)
    [Command::Success, NoOutput.new, env] 
  rescue Yamlsh::Env::CdError => e
    [Command::Error, Output.new("cd: #{e.message}"), env] 
  end
end
