module GoogleAnalyticsHelper
  def tracking_id
    Rails.application.credentials.dig(:google_analytics, :tracking_id)
  end
end
