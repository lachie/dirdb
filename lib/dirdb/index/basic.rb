module DirDB
  module Index
    class Basic 
      def initialize(resource_class)
        @resource_class = resource_class
      end
      
      # access indexes
      def indexes
        prepare! unless @indexes
        @indexes
      end
      
      # access resources
      def resources
        prepare! unless @resources
        @resources
      end
      
      # prepare the lazy variables indexes & resources.
      def prepare!
        scan_resources!
        build_index!
      end
      
      # scan all the resources resource_class knows about
      def scan_resources!
        @resources = {}
        @resource_arguments = {}
        
        @default_order = []
        Dir[@resource_class.glob].each do |path|
          @default_order << basename = File.basename(path)
          
          @resource_arguments[basename] = resource_arguments = @resource_class.scan_file(path)
          
          instantiate_resource!(basename,resource_arguments)
        end
      end
      
      # instantiate one resource
      def instantiate_resource!(basename,resource_arguments)
        @resources[basename] = resource = @resource_class.new(*resource_arguments)
        resource._setup_path(basename)
      end
      
      # build resources using the resource_class
      def build_index!
        @indexes = {}
        
        @indexes = @resource_class.build_indexes(@resources)
        @indexes[:_default] ||= @default_order
      end
  
      # get a resource
      def get(basename)
        resources[basename]
      end
  
      # get all resources sorted using +index+
      def all(index_name=nil)
        index_name ||= :_default
        selected_index = indexes[index_name] || raise(ArgumentError,"Index '#{index_name}' doesn't exist.")
        
        pp selected_index
        
        resources.values_at(*selected_index)
      end
    end
  end
end