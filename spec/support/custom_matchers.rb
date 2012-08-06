module CustomMatchers
  include RSpec::Rails::Matchers

  class IncludeMatch
    def initialize(expected)
      expected = /#{Regexp.escape(expected)}/ unless expected.kind_of?(Regexp)
      @expected = expected
    end

    def matches?(target)
      @target = target
      !target.find { |item| item =~ @expected }.nil?
    end

    def failure_message
      "Expected #{@target.inspect} to include string that matches #{@expected}"
    end
  end

  def include_match(expected)
    IncludeMatch.new(expected)
  end
end