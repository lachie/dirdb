module DirDB
  module Resource
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        attr_reader :path, :basename
      end
    end
    
    def _setup_path(basename)
      @basename = basename
      @path = File.join(self.class.path,basename)
    end
    
    def index
      self.class.index
    end
    
    def read
      File.read(path)
    end
    
    module ClassMethods
      def path=(path)
        @path = path
      end
      
      def path
        @path
      end
      
      def to_slug
        self.to_s.gsub(/[A-Z]/) {|c| "_#{c.downcase}"}.sub(/^_/,'')
      end
      
      def dotfile_path(ext=nil)
        if ext
          File.join(path,".#{to_slug}_index.#{ext}")
        else
          File.join(path,".#{to_slug}_index")
        end
      end
      
      def index_class=(index_class)
        @index_class = index_class
      end
      
      def index_class(index_class=nil)
        if index_class
          @index_class = index_class
        else
          @index_class || DirDB::Index::Basic
        end
      end
      
      def index(name,&block)
        @indexes ||= {}
        @indexes[name] = block
      end
      
      def lookup(name,&block)
        @lookups ||= {}
        @lookups[name] = block
      end
      
      def build_indexes(resources)
        built_index = {}
        
        (@indexes || {}).each do |(name,block)|
          built_index[name] = resources.values.sort_by(&block).map {|a| a.basename}
        end
        
        built_index
      end
      
      def build_lookups(resources)
        built_lookups = {}
        
        (@lookups || {}).each do |(name,block)|
          built_lookups[name] = lookup = Hash.new {|h,k| h[k] = []}
          
          resources.each do |(_,res)|
            lookup[block[res]] << res
          end
        end
        
        built_lookups
      end
      
      def resource_index
        @resource_index ||= index_class.new(self)
      end
      
      def glob(glob=nil)
        if glob
          @glob = glob
        else
          @glob ||= '*'
          File.join(@path,@glob)
        end
      end
      

      
      def all(index_name=nil)
        resource_index.all(index_name)
      end
      
      def get(basename)
        resource_index.find(:_default, basename)
      end
      
      def find(lookup_name,key)
        resource_index.find(lookup_name,key)
      end
      
      def first(lookup_name,key)
        resource_index.find(lookup_name,key).first
      end
    end
  end
end