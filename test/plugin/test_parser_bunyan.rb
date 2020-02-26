require "helper"
require "fluent/plugin/parser_bunyan.rb"

class BunyanParserTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Parser.new(Fluent::Plugin::BunyanParser).configure(conf)
  end
end
