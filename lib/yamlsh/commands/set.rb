Commands['set'] = lambda do |env, command, args|
  begin
    target, _ = args
    Readline.pre_input_hook = proc do
      old_value = begin
                    env.get(target).to_s || ''
                  rescue
                    ''
                  end
      Readline.insert_text(old_value)
      Readline.redisplay
    end
    new_value = Readline.readline("Hit ENTER to stop typing\n> ", true)
    env.set(target, new_value)
    Readline.pre_input_hook = nil
    [Command::Success, Output.new(new_value), env]
  rescue Yamlsh::Env::SetError => e
    [Command::Error, Output.new("set: #{e.message}"), env] 
  end
end
