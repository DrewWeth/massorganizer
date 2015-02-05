class HomeController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  def index
  end

  def admin
    if int_mod?
      @interests_arr = Interest.all.map{|x| [ x.name + " in " + x.organization.name, x.id]}
      @interests_arr.push(["All", -1])
    else
      redirect_to root_path
    end

  end


  private

end
