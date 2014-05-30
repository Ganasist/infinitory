class RequestMailer < ActionMailer::Base

	def request_email(email, department, institute)
    @email  = email
    @department = department
    @institute = institute
    mail(to: "feedback@infinitory.com", from: @email, subject: "Account request from #{ @email }" )
  end

end
