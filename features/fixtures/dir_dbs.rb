$:.unshift File.dirname(__FILE__)+'/../../lib'
require 'dirdb'

class BasicDirDB
  include DirDB::Scanner
end