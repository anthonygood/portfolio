class EtchingsController < ApplicationController
  def index
    @etchings = Etching.all
  end

  def show
    @etching = Etching.find params[:id]
  end
end
