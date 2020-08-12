require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    assign(:comment, Comment.new(
      title: "MyString",
      description: "MyText",
      checked: false,
      author: "MyString"
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "input#comment_title[name=?]", "comment[title]"

      assert_select "textarea#comment_description[name=?]", "comment[description]"

      assert_select "input#comment_checked[name=?]", "comment[checked]"

      assert_select "input#comment_author[name=?]", "comment[author]"
    end
  end
end
