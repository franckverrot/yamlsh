require 'helper'
require 'yamlsh/path'

class PathTest < Minitest::Test
  def setup
    @path = Yamlsh::Path.new
  end

  def test_initialize_empty
    assert_equal 0, @path.segments.size
  end

  def test_push_pop_segmnets
    @path.push 'foo'
    assert_equal 1, @path.segments.size
    assert_equal ['foo'], @path.segments

    result = @path.pop
    assert_equal 0, @path.segments.size
    assert_equal 'foo', result
  end

  def test_reset
    @path.push 'foo'
    @path.reset

    assert_equal 0, @path.segments.size
  end
end
