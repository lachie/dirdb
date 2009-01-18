Given /^the yaml metadata handler$/ do
  require 'yaml'
  class YamlMetadata
    def self.scan(filename)
      YAML.load_file(filename)
    end
  end
  
  @yaml_metadata_handler = YamlMetadata
end

When /^I read the file with the yaml metadata handler$/ do
  @yaml_result = @yaml_metadata_handler.scan(@yaml_filename)
end

Then /^I collect the yaml metadata$/ do
  @yaml_result.should have(1).key
  @yaml_result.should include('key1' => 'value1')
end
