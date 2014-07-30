require 'spec_helper'

describe PhraseFile do

  before(:each) do
    subject { PhraseFile.new }
    file_content! default_content
  end

  context "random" do
    it "should return first phrase when random is zero" do
      PhraseFile.any_instance.stub(:random_position).and_return(0)

      subject.random.should eq 'phrase one'
    end

    it "should return last phrase when random is last char in file" do
      last_char = 37
      PhraseFile.any_instance.stub(:random_position).and_return(last_char)

      subject.random.should eq 'phrase three'
    end
  end

  context "append" do
    it "should append phrase to end of file" do
      new_phrase = "phrase four"

      subject.append new_phrase

      read_file_content.should eq "#{default_content} | #{new_phrase}"
    end
  end

end

def file_content!(content)
  spec_source_file = "#{Rails.root}/spec/phrases_source.txt"

  File.open(spec_source_file, 'w+') { |f| f.write(content) }
end

def read_file_content
  spec_source_file = "#{Rails.root}/spec/phrases_source.txt"

  File.read(spec_source_file)
end

def default_content
  "phrase one | phrase two | phrase three"
end