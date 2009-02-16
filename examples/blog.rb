require File.dirname(__FILE__)+'/../lib/dirdb'
require 'ostruct'

class Article < OpenStruct
  include DirDB::Resource
  
  # index_class DirDB::Index::YAML
  glob '*.haml'
  
  index :by_ctime do |article|
    File.ctime(article.path)
  end
  
  lookup :by_slug do |article|
    article.slug
  end
  
  attr_reader :title
  
  def self.scan_file(path)
    # title = nil
    #     IO.foreach(path) do |line|
    #       if line[/^\s*-#\s*title:\s*(.*)$/]
    #         title = $1
    #         break
    #       end
    #     end
    
    info = {
      :title => File.basename(path,'haml').sub(/^\d+_/,'').gsub('_',' '),
      :slug  => File.basename(path,'haml').sub(/\.$/,'')
    }
    pp info
    [ info ]
  end

end

if __FILE__ == $0
  require 'pp'
  Article.path = File.dirname(__FILE__) + '/blog'
  
  p = Article.all(:by_ctime).first
  puts p.path
  puts p.read.class
end