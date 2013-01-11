require 'test_helper'

class IssuePatchTest < ActiveSupport::TestCase
  ENV['BASECAMP_URL'] = 'http://basecamp.com'
  ENV['BASECAMP_TOKEN'] = '12345'
  ENV['BASECAMP_PROJECT_ID'] = '24680'

  MessageTestStub = Struct.new(:title, :body)

  setup do
    @issue = Issue.new(
      :subject => "This is the title",
      :description => "This is the body",
      :status => IssueStatus.new(:name => 'Awaiting Feedback')
    )

    @message = MessageTestStub.new
    @message.stubs(:save)

    Basecamp.stubs(:establish_connection!)
    Basecamp::Message.stubs(:new => @message, :find => @message)
  end

  test "Basecamp connection should be established" do
    Basecamp.expects(:establish_connection!).
      with('http://basecamp.com', '12345')
    @issue.update_basecamp
  end

  test "new issues should create new messages" do
    Basecamp::Message.expects(:new).
      with(:project_id => '24680').returns(@message)
    @message.expects(:save)
    @issue.update_basecamp
  end

  test "issues with existing message should update those messages" do
    @issue.basecamp_message_id = 13579
    Basecamp::Message.expects(:find).
      with(13579).returns(@message)
    @message.expects(:save)
    @issue.update_basecamp
  end

  test "message title should contain the issue's id" do
    @issue.update_basecamp
    assert_match @issue.id.to_s, @message.title
  end

  test "message title should contain the issue's status" do
    @issue.update_basecamp
    assert_match @issue.status.name, @message.title
  end

  test "message title should contain the issue's subject" do
    @issue.update_basecamp
    assert_match @issue.subject, @message.title
  end

  test "message body should match the issue's description" do
    @issue.update_basecamp
    assert_match @issue.description, @message.body
  end
end
