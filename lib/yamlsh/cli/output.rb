class Output < Struct.new(:content)
  def show
    $stdout.puts "=> #{content}"
  end
end
