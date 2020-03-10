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

require "fluent/plugin/parser"
#require "fluent/parser"

module Fluent
  module Plugin
    class BunyanParser < JSONParser
      Fluent::Plugin.register_parser("bunyan", self)

      def configure(conf)
        conf["time_format"] = "%iso8601"
        super(conf)
      end

      def parse(text)
        super(text) do |time, record|
          record["severity"] = severity(record["level"] || 0)
          record["host"]     = record.delete("hostname")
          record["message"]  = record.delete("msg")

          record.delete("v")
          yield time, record
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
        return "0.0.2"
      end
    end
  end
end
