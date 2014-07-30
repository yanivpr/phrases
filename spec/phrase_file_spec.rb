require 'spec_helper'

describe PhraseFile do

  before(:each) do
    subject { PhraseFile.new }
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
end