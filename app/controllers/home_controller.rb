class HomeController < ApplicationController
  def index
    @guest = Guest.new
    @guests = Guest.all.order(:lastname)
  end

  def create
    @guest = Guest.new(guest_params)
    puts "**************************"
    puts params.inspect

    if @guest.save
      redirect_to "home#index", notice: "Guest was added to the DNR list"
    else
      #
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:firstname, :lastname, :dob, :reason)
  end
end
