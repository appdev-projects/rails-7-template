class KeepAliveJob < ApplicationJob
  queue_as :default

  def perform(*args)
    KeepAliveService.new("https://perfect-pals.onrender.com/").call
  end
end
