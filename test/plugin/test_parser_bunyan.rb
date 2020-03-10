require "helper"
require "fluent/plugin/parser_bunyan.rb"

class BunyanParserTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  CONFIG = %[
    pattern apache
  ]

  sub_test_case "parse" do
    test "can parse simple entry" do
      driver = create_driver(CONFIG)
      text = '{"hostname":"helloworld-go-helloworld-5649dfd7bd-k8954","level":30,"msg":"The message","name":"helloworld","pid":1,"scope":"main","tid":1,"time":"2020-03-10T07:08:41Z","topic":"main","v":0}'
      expected_time   = Time.utc(2020, 3, 10, 7, 8, 41).to_i
      expected_record = {
        "host"     => "helloworld-go-helloworld-5649dfd7bd-k8954",
        "name"     => "helloworld",
        "severity" => "info",
        "level"    => 30,
        "message"  => "The message",
        "topic"    => "main",
        "scope"    => "main",
        "pid"      => 1,
        "tid"      => 1,
      }
      driver.instance.parse(text) do |time, record|
        assert_equal(expected_record, record)
        assert_equal(expected_time,   time)
      end
    end

    test "can parse entry with custom properties" do
      driver = create_driver(CONFIG)
      text = '{"hostname":"helloworld-go-helloworld-5649dfd7bd-k8954","level":50,"msg":"Failed to be happy","name":"helloworld","pid":1,"reqid":"0ba850ff-1e1f-4bcf-8288-135927bb850f","scope":"start","tid":21,"time":"2020-03-10T15:04:19Z","topic":"server","v":0}'
      expected_time   = Time.utc(2020, 3, 10, 15, 4, 19).to_i
      expected_record = {
        "host"     => "helloworld-go-helloworld-5649dfd7bd-k8954",
        "name"     => "helloworld",
        "severity" => "error",
        "level"    => 50,
        "message"  => "Failed to be happy",
        "topic"    => "server",
        "scope"    => "start",
        "pid"      => 1,
        "tid"      => 21,
        "reqid"    => "0ba850ff-1e1f-4bcf-8288-135927bb850f",
      }
      driver.instance.parse(text) do |time, record|
        assert_equal(expected_record, record)
        assert_equal(expected_time,   time)
      end
    end

    test "can parse entry with complex custom properties" do
      driver = create_driver(CONFIG)
      text = '{"hostname":"helloworld-go-helloworld-5649dfd7bd-k8954","level":50,"msg":"Failed to be happy","name":"helloworld","pid":1,"err":{"text": "aouch", "code": 404},"reqid":"0ba850ff-1e1f-4bcf-8288-135927bb850f","scope":"start","tid":21,"time":"2020-03-10T15:04:19Z","topic":"server","v":0}'
      expected_time   = Time.utc(2020, 3, 10, 15, 4, 19).to_i
      expected_record = {
        "host"     => "helloworld-go-helloworld-5649dfd7bd-k8954",
        "name"     => "helloworld",
        "severity" => "error",
        "level"    => 50,
        "message"  => "Failed to be happy",
        "topic"    => "server",
        "scope"    => "start",
        "pid"      => 1,
        "tid"      => 21,
        "reqid"    => "0ba850ff-1e1f-4bcf-8288-135927bb850f",
        "err"      => {
          "code" => 404,
          "text" => "aouch",
        },
      }
      driver.instance.parse(text) do |time, record|
        assert_equal(expected_record, record)
        assert_equal(expected_time,   time)
      end
    end
  end

  private

  def create_driver(conf = CONFIG)
    Fluent::Test::Driver::Parser.new(Fluent::Plugin::BunyanParser).configure(conf)
  end
end
