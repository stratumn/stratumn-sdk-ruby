# Copyright 2017 Stratumn SAS. All rights reserved.
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

module AgentClient
  ##
  # Represents a link in a Stratumn application
  class Segment
    include Request
    include Helper

    attr_accessor :agent, :meta, :state, :link, :link_hash

    def initialize(agent, obj)
      self.agent = agent

      self.link = obj['link']
      self.meta = link['meta']
      self.state = link['state']
      self.link_hash = obj['meta']['linkHash']

      agent.agent_info['actions'].each do |(method, _)|
        add_transition_method(method)
      end
    end

    def previous
      agent.get_segment(meta['prevLinkHash']) if meta['prevLinkHash']
    end

    def find_segments(options = {})
      agent.find_segments(options)
    end

    def load
      agent.get_segment(link_hash)
    end

    def self.from(segment)
      agent = Agent.load(segment['meta']['agentUrl'])

      new(agent, segment)
    end

    private

    def add_transition_method(method)
      define_singleton_method(method) do |*args|
        url = "#{agent.url}/segments/#{link_hash}/#{method}"

        result = post(url, json: args)

        self.class.new(agent, result)
      end

      singleton_class.send(:alias_method, underscore(method), method)
    end
  end
end
