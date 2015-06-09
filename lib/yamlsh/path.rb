module Yamlsh
  class Path
    def initialize
      @segments = Array.new
    end

    def to_s
      if @segments.any?
        segments
      else
        ['root']
      end.join('.')
    end

    def push path
      @segments.push path
    end

    def reset
      @segments.clear
    end

    def pop
      @segments.pop
    end

    def segments
      @segments
    end
  end
end
