class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    @payments = Payment.all
    render json: @payments
  end

  def show
    @payment = Payment.find(params[:id])
    render json: @payment
  end

  def create

  @payment = Payment.new(:amount => params[:amount].to_f, :loan_id => params[:loan_id].to_i)

    if @payment.can_process_payment?
        Payment.transaction do
            @payment.process_payment
         render status: 201, json: {
         message: "Payment processed"}
    else
          render status: 403, json: {
           message: "Payment unable to process"}
     end
  end


  private
    def payment_params
      params.fetch(:payment, {})
    end
end