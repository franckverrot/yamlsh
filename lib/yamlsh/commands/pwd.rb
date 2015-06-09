Commands['pwd'] = lambda do |env, command, args|
  begin
    pwd = env.pwd
    [Command::Success, Output.new(pwd), env]
  rescue Yamlsh::Env::PwdError => e
    [Command::Error, Output.new("pwd: #{e.message}"), env] 
  end
end
