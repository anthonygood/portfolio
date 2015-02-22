class InquiriesController < ApplicationController
  def create
    Inquiry.create inquiry_params
    render nothing: true, status: 200
  end

  private

  def inquiry_params
    params.permit(:name, :email, :phone, :message)
  end
end
