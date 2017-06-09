class RoundsController < ApplicationController

  def create
    @round = Round.create(key: "key")
    redirect_to round_path(@round)
  end

  def show
    # respond_to do |format|
    #     format.js {render layout: false}
    # end
  end

  def destroy
  end

end
