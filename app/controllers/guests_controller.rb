class GuestsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :complete_registration, if: :user_signed_in?
  before_action :set_guest, only: %i[edit update destroy]

  def new; end

  def index
    @guest = Guest.new
    @guest.user_id = current_user.id if user_signed_in?
    # @guest.firstname = Faker::Name.first_name
    # @guest.lastname = Faker::Name.last_name
    # @guest.dob = Faker::Date.birthday(min_age: 18, max_age: 65)
    @guests = Guest.all.order(:lastname)
  end

  def create
    redirect_to root_url unless user_signed_in?
    @guest = current_user.guests.build(guest_params)

    if @guest.save
      flash[:new] = true
      redirect_to root_url, notice: "#{@guest.firstname} #{@guest.lastname} was added to the DNR list"
    else
      @guests = Guest.all.order(:lastname)
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @guest.update(guest_params)
      redirect_to root_url, notice: "#{@guest.firstname} #{@guest.lastname} was updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    name = "#{@guest.firstname} #{@guest.lastname}"
    @guest.destroy
    redirect_to root_url, notice: "#{name} was successfully removed from this list."
  end

  private

  def set_guest
    @guest = Guest.find(params[:id])
  end

  def guest_params
    params.require(:guest).permit(:firstname, :lastname, :dob, :reason, :id_number, :city, :state, :zip)
  end

  def complete_registration
    return unless current_user.name.blank? || current_user.display_name.blank?

    redirect_to users_edit_details_path, notice: "Please complete registration."
  end
end
