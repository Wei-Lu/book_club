require 'spec_helper'

describe "books/show" do
=begin  
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :title => "Title",
      :author => "Author",
      :book_type => "Type",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Author/)
    rendered.should match(/Type/)
    rendered.should match(/MyText/)
  end
=end
end
