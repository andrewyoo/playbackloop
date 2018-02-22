Aws.config[:credentials] = Aws::Credentials.new(Rails.application.secrets.aws[:access_key], Rails.application.secrets.aws[:secret_key])
Aws.config[:region] = Rails.application.secrets.aws[:region]
