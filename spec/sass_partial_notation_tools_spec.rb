require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_partial_notation_tools')

describe "Sass Partial Notation Tools" do
  before :all do
    @test_directory = "test_files"
    @root_directory = Dir.getwd
    Dir.mkdir @test_directory
  end

  before :each do
    Dir.chdir @test_directory
  end

  context "turn 'partialname' shorthand into '_partialname.sass' partial" do
    it "Should determine which file the shorthand is referring to" do
      pending "Don't yet know the testing approach"
    end
    it "Should warn if the shorthand doesn't refer to a known file" do
      pending "Need to figure out warnings"
    end
    it "Should warn if the shorthand ambigiously points to multiple files" do
      pending "Wouldn't normally be reasonable in a Sass project anyways"
    end
  end

  context "turn '_partialname.sass' partial into 'partialname' shorthand" do
    before :each do
      @scss = {partial: '_scss.scss', shorthand: 'scss'}
      @sass = {partial: '_sass.sass', shorthand: 'sass'}
      @cssscss = {partial: 'cssscss.css.scss', shorthand: 'cssscss'}
      @csssass = {partial: 'csssass.css.sass', shorthand: 'csssass'}
      @nest_dir = 'nest'
      @nested_partial = {partial: "#{@nest_dir}/_nest.sass", shorthand: "#{@nest_dir}/nest"}
    end

    it "Should trim .sass or .scss" do
      SassPartial.shorthandify(@scss[:partial]).should eq @scss[:shorthand]
      SassPartial.shorthandify(@sass[:partial]).should eq @sass[:shorthand]
    end

    it "Should trim .css as well" do
      SassPartial.shorthandify(@cssscss[:partial]).should eq @cssscss[:shorthand]
      SassPartial.shorthandify(@csssass[:partial]).should eq @csssass[:shorthand]
    end

    it "Should handle nested partials" do
      SassPartial.shorthandify(@nested_partial[:partial]).should eq @nested_partial[:shorthand]
    end
  end

  after :each do
    Dir.chdir @root_directory
  end

  after :all do
    teardown_test_directory @test_directory
  end
end
