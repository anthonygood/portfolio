class InquiriesController < ApplicationController
  def create
    inquiry = inquiry_params
    Inquiry.create inquiry
    InquiryMailer.notification(inquiry).deliver
    render nothing: true, status: 200
  end

  private

  def inquiry_params
    params.permit(:name, :email, :phone, :message)
  end
end
