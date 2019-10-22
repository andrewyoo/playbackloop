creds = Rails.application.credentials[Rails.env.to_sym]
Aws.config[:credentials] = Aws::Credentials.new(creds[:aws][:access_key], creds[:aws][:secret_key])
Aws.config[:region] = creds[:aws][:region]
