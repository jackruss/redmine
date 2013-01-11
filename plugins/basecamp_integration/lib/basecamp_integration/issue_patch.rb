module BasecampIntegration
  module IssuePatch
    extend ActiveSupport::Concern

    included do
      after_save :update_basecamp
    end

    def update_basecamp
      BasecampIntegration::Publisher.publish(self)
    end
  end
end
