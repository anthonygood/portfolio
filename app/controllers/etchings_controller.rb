class EtchingsController < ApplicationController

  ORDER = [
    15, 10, 5
  ]

  def index
    @etchings = Etching.includes(:prints).all
  end

  def show
    @etching = Etching.includes(:prints).find params[:id]
    @next    = Etching.next @etching
    @prev    = Etching.previous @etching
    
    redirect_to :etchings unless @etching.listed
  end

  def exhibit
    @etchings = Etching.all
  end

  private

  def arbitrary_order(ids)
    Etching.find(ids)
           .index_by(&:id)
           .slice(*ids)
           .values
  end

end
