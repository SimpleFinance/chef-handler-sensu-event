# chef-handler-sensu-event.rb
# 
# Author: Simple Finance <ops@simple.com>
# License: Apache License, Version 2.0
#
# Copyright 2013 Simple Finance Technology Corporation.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Reports failed Chef runs to Sensu

require 'rubygems'
require 'chef'
require 'chef/handler'
require 'json'
require 'socket'

class SensuEvent < Chef::Handler
  attr_reader :server, :port, :severity, :handlers

  def opts
    return {
      :server = "127.0.0.1",
      :port = 3030,
      :severity = 1,
      :handlers = ["default"]
    }
  end

  def initialize(options = opts)
    @server = options[:server]
    @port = options[:port]
    @severity = options[:severity]
    @handlers = options[:handlers]
  end

  def create_json
    stringify = run_status.success? ? "ran successfully" : "failed to run"
    severity = run_status.success? ? 0 : @severity
    hash = {
      'handlers' => @handlers,
      'name' => 'chef-run-result',
      'output' => "Chef #{stringify} on #{node.name}",
      'status' => severity }
    return JSON.generate(hash)
  end

  def report
    sock = TCPSocket.new(@server, @port)
    sock.write(create_json)
    sock.close
  end
end

