class ApplicationMailer < ActionMailer::Base
  default from: Proc.new { Configs::Tokens::Smtp.find_by(is_default: true).sender }
  layout 'mailer'
end