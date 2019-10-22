if Rails.env.production?
  ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
    access_key_id: Rails.application.credentials[Rails.env.to_sym][:aws][:access_key],
    secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws][:secret_key]
end
