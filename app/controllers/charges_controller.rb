class ChargesController < ApplicationController
  def create
    @user = current_user
    
    # Creates a Stripe Customer object, for associating with the charge
    
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    
    charge = Stripe::Charge.create(
      customer: customer.id, # This is not user_id but rather the id generated for Stripe::Customer
      amount: 15_00,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd'
    )
    
    @user.update_attributes(role: 'premium')
    
    flash[:notice] = "Thanks for your purchase of premium membership, #{current_user.email}. You can now create private wikis."
    
    redirect_to root_path
    
    rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Blocipedia Premium Membership - #{current_user.email}",
      amount: 15_00
    }
  end
end
