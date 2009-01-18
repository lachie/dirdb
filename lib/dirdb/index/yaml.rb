require 'yaml'

module DirDB
  module Index
    class YAML < Basic
      def dotfile
        @dotfile ||= @resource_class.dotfile_path('yaml') 
      end
      
      def prepare!
        if File.exists?(dotfile)
          read_index!
        else
          super
          write_index!
        end
      end
      
      def read_index!
        state = ::YAML.load_file(dotfile)
        @indexes = state[:indexes]
        @resource_arguments = state[:resource_arguments]
        
        @resource_arguments.each do |(basename,args)|
          instantiate_resource!(basename,resource_arguments)
        end
      end
      
      def write_index!
        state = {
          :indexes => @indexes,
          :resource_arguments => @resource_arguments
        }
        open(dotfile,'w') {|f| f << state.to_yaml}
      end

    end
  end
end