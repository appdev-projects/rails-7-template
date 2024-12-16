class KeepAliveService
  def initialize(url)
    @url = url
  end

  def call
    response = HTTP.timeout(60).get(@url)

    if response.status.success?
      Rails.logger.info("Successfully pinged #{@url}")
      response.status
    else
      Rails.logger.warning("Unable to ping #{@url}, recieved status #{response.status}")
      response.status
    end
  end
end
