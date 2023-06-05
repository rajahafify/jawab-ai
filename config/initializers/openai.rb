OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.ai_service[:llm_api_key]
end
