module DirDB
end

__DIR__ = File.dirname(__FILE__)

require "#{__DIR__}/dirdb/resource"

require "#{__DIR__}/dirdb/index"
require "#{__DIR__}/dirdb/index/basic"
require "#{__DIR__}/dirdb/index/yaml"