require 'readline'
require 'yamlsh/env'

module Yamlsh
  class CLI
    def initialize(file, history_file)
      @env = Env.new(file)
      @history_file = history_file
    end

    def show_prompt
      Readline.readline("$(#{@env.current_path})> ", true)
    end

    def load_history
      IO.foreach(@history_file) do |line|
        Readline::HISTORY.push line.chomp if line.size > 0
      end
    rescue Errno::ENOENT
      if $-w
        puts "No history file located at: #{@history_file}"
      end
    end

    def add_to_history line
      File.open(@history_file, 'a+') { |f| f.puts line }
    end

    def run
      show_program_name

      Readline.completion_append_character = ""
      Readline.completion_proc = Proc.new do |str|
        @env.keys.grep(/^#{Regexp.escape(str)}/)
      end

      trap('INT') do
        Readline.delete_text
        Readline.point = 0
        Readline.refresh_line
      end

      load_history

      begin
        loop do
          command_line = show_prompt
          exit 0 if command_line.nil?

          command, *args = command_line.split

          unless command
            Readline::HISTORY.pop# unless command && command.size == 0
          end

          begin
            if Readline::HISTORY[Readline::HISTORY.length-2] == command
              Readline::HISTORY.pop
            end
          rescue IndexError
          end
          status, output, @env = Commands[command.downcase][@env, command, args]
          output.show
          add_to_history command_line if status == Command::Success
        end
      rescue RuntimeError => e
        puts "\n\nQuitting #{e.class} #{e.message}...\n"
        puts e.backtrace
        exit 1
      end
    end
  end
end
