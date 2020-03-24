#
# Copyright 2020- Gildas Cherruel
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "fluent/parser"

module Fluent
  module Plugin
    class BunyanParser < JSONParser
      Fluent::Plugin.register_parser("bunyan", self)

      def configure(conf)
        conf["time_format"] = "%iso8601"
        super(conf)
      end

      def parse(text)
        # Example of a log line from containerd we want to get stuff from:
        # 2020-03-16T22:14:05.710251038+09:00 stdout F {"UserAgent":"kube-probe/1.17","hostname":"helloworld-go-helloworld-5649dfd7bd-k8954","level":30,"msg":"request start: GET /","name":"helloworld","pid":1,"remote":"10.1.10.1:60114","reqid":"e4745ed6-82d4-4013-aeda-1d02bef42331","scope":"/","tid":17,"time":"2020-03-16T13:14:05Z","topic":"route","v":0}
        # Example of a log line from docker for mac we want to get stuff from:
        # {"log":"{\"UserAgent\":\"HTTPie/2.0.0\",\"hostname\":\"helloworld-859745b47d-5dlbn\",\"level\":30,\"msg\":\"request start: GET /\",\"name\":\"helloworld\",\"pid\":1,\"remote\":\"192.168.65.3:42018\",\"reqid\":\"ba054f49-d97e-4970-89c4-dd3b75270e6a\",\"scope\":\"/\",\"tid\":14,\"time\":\"2020-03-24T08:29:02Z\",\"topic\":\"route\",\"v\":0}\n","stream":"stdout","time":"2020-03-24T08:29:02.3995324Z"}
        if text =~ /[^{]*({.*)/
          super(text.sub(/[^{]*({.*)/, '\1')) do |time, record|
            if record then
              if record["log"] then # This is a Docker style log message
                begin
                  r = JSON.load(record["log"])
                  r.delete("time")
                  record.merge!(r)
                  record.delete("log")
                rescue JSON::ParserError
                end
              end
              record["severity"] = severity(record["level"] || 0)
              record["host"]     = record.delete("hostname")
              record["message"]  = record.delete("msg")

              record.delete("v")
            end
            yield time, record
          end
        end
      end

      def severity(level)
        return "fatal" if level >= 60
        return "error" if level >= 50
        return "warn"  if level >= 40
        return "info"  if level >= 30
        return "debug" if level >= 20
        return "trace"
      end

      def version
        return "0.0.4"
      end
    end
  end
end
