class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
    if current_user != nil
      @owned = current_user.organizations
    else
      @owned = []
    end

  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @interests = @organization.interests
    @interest = Interest.new


    if int_mod?
      @email_list = []
      @interests.each do |a|
          @email_list << a.devices.reject{|b| b.email.nil? and b.pawprint.nil? }.map{|a| a.email || a.pawprint + "@mail.missouri.edu"} if a.devices.count > 0
      end
      @devices_with_no_interests = Device.where.not(:email => nil)
      @devices_with_no_interests.each do |d|
        @email_list << d unless @email_list.inlcude?(d.email)
      end

      @email_list = @email_list.join(', ')
    end

  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    if current_user != nil

      @organization = Organization.new(organization_params)
      @organization.owner_id = current_user.id
      respond_to do |format|
        if @organization.save
          format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
          format.json { render :show, status: :created, location: @organization }
        else
          format.html { render :new }
          format.json { render json: @organization.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_registration_path, notice: 'Please sign up to start making an organization!' }

      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :desc, :phone_number, :owner_id)
    end
end
