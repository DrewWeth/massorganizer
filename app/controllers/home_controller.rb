class HomeController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  def index
  end

  def admin
    if current_user.try(:has_role?, :admin)
      @interests_arr = Interest.all.map{|x| [ x.name + " in " + x.organization.name, x.id]}

      @admins = User.with_role(:admin)
    else
      redirect_to root_path
    end


  end


  private

end
