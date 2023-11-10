class CheckoutController < ApplicationController

  
  def create
    @event_id = params[:event_id]
    @total = params[:total].to_d
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      metadata: {
        event_id: @event_id
      },
      mode: 'payment',
      customer_email: current_user.email,
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @user = current_user
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @event_id = @session.metadata.event_id
    @attendee = Attendance.new(user_id: @user.id, event_id: @event_id, stripe_customer_id: @session.id)
    @attendee.save
  end

  def cancel
  end
end