require File.dirname(__FILE__)+'/../lib/dirdb'

class Article
  include DirDB::Resource
  
  # index_class DirDB::Index::YAML
  # glob '*.haml'
  
  index :by_ctime do |article|
    File.ctime(article.path)
  end
  index :by_reverse_length do |article|
    -article.title.length
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
    
    # title
    File.basename(path,'haml').sub(/^\d+_/,'').gsub('_',' ')
  end
  
  def initialize(title)
    @title = title || ''
  end
end

if __FILE__ == $0
  require 'pp'
  Article.path = File.dirname(__FILE__) + '/blog'
  
  pp Article.all(:by_ctime)
end