class HTMLEscapeMessageFilter < ApplicationMessageFilter
  def self.filter(text)
    ApplicationController.helpers.sanitize(text, tags: %w())
  end
end
