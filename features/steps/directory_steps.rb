Given /^a directory of files$/ do
  @work_path = work_path('dir')
  5.times do |num|
    f = File.join(@work_path, "file#{num}.yml")
    open(f,'w') { |f| f << {'index' => num}.to_yaml }
  end
end

Given /^nothing else$/ do
  # no op
end

Given /^a dirdb of the directory$/ do
  require fixture_path('dir_dbs')
  @dirdb = BasicDirDB.new(@work_path)
end

Given /^I create a new file$/ do
end


When /^I access a file's information$/ do
  @file_info = @dirdb.get('file2.yml')
end

When /^I access the new file's information$/ do
  @file_info = @dirdb.get('file_new.yml')
end

Then /^I get the file information$/ do
  @file_info.should_not be_nil
end

Then /^I get the new file information$/ do
  @file_info.should_not be_nil
end