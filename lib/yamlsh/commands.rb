require 'yamlsh/cli/output'
require 'yamlsh/cli/no_output'

Commands = Hash.new do
  lambda do |env, command, args|
    [Command::Error, Output.new("unknown command #{command}"), env]
  end
end

module Command
  Success = Class.new
  Error = Class.new
end
