class GroupLeader::ParameterSanitizer < Devise::ParameterSanitizer
    private
    def sign_in
      default_params.permit self.for(:sign_in)
    end

    def sign_up
        default_params.permit(:first_name, :last_name, :email, :institute_name, :department_name,
        											:password, :password_confirmation)
    end

    def account_update
      default_params.permit self.for(:account_update)
    end
end