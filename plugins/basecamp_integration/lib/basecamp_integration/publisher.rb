module BasecampIntegration
  class Publisher
    def self.publish(issue)
      self.new(issue).publish
    end

    def initialize(issue)
      @issue = issue
      connect_to_basecamp
    end

    def publish
      update_message do |message|
        message.title = "##{@issue.id} [#{@issue.status.name}] #{@issue.subject}"
        message.body = @issue.description
      end
    end

    def connect_to_basecamp
      Basecamp.establish_connection!(
        ENV['BASECAMP_URL'],
        ENV['BASECAMP_TOKEN']
      )
    end

    def update_message(&block)
      message = find_or_create_message
      block.call(message)
      message.save
    end

    def find_or_create_message
      if @issue.basecamp_message_id.nil?
        Basecamp::Message.new(:project_id => ENV['BASECAMP_PROJECT_ID'])
      else
        Basecamp::Message.find(@issue.basecamp_message_id)
      end
    end
  end
end
