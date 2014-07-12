class AccountsController < ApplicationController
	before_action :set_lab

	def show
		
	end

	def new
		@account = Account.new
		@tr_data = Braintree::TransparentRedirect.create_customer_data(redirect_url: lab_account_path(@lab),
																															     customer: { company: @user.name })
	end

	def edit
		
	end

	def create
		@account = Account.new(account_params)
		result = Braintree::Customer.create(
	    :first_name => params[:account][:first_name],
	    :last_name => params[:account][:last_name],
	    :credit_card => {
	      :number => params[:account][:cc_number],
	      :expiration_month => params[:account][:cc_exp_month],
	      :expiration_year => params[:account][:cc_exp_year],
	      :cvv => params[:cvv]
	    }
	  )
	  if result.success?
	  	flash[:notice] = "Account created!! for #{result.customer.first_name} #{result.customer.last_name}"
	    redirect_to lab_path(@lab)
	  else	  	
	  	flash[:notice] = "Error: #{result.message}"
	  	render action: 'new'
	  end
		
	end	

	def update

	end

	def destroy
		
	end

	private
		def set_lab
      @lab = Lab.find(params[:lab_id])
    end

    def account_params
    	params.require(:account).permit(:first_name, :last_name, :cc_number, :cc_exp_number, :cc_exp_year, :cvv)
    end
end
