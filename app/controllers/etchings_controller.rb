class EtchingsController < ApplicationController
  def index
    @etchings = Etching.includes(:prints).all
  end

  def show
    @etching = Etching.includes(:prints).find params[:id]
  end
end
