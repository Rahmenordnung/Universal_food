require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      title: "MyString",
      description: "MyText",
      checked: false,
      author: "MyString"
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "input#comment_title[name=?]", "comment[title]"

      assert_select "textarea#comment_description[name=?]", "comment[description]"

      assert_select "input#comment_checked[name=?]", "comment[checked]"

      assert_select "input#comment_author[name=?]", "comment[author]"
    end
  end
end
