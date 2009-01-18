require 'fileutils'

module FixtureHelper
  include FileUtils
  
  def fixture_path(*extras)
    File.expand_path( File.join( File.dirname(__FILE__), '..', 'fixtures', *extras) )
  end
  
  def work_path(name)
    path = fixture_path('work',name)
    rm_rf path
    mkdir_p path
    path
  end
end

World do |w|
  w.extend FixtureHelper
  w
end