class DeviceInterestsController < ApplicationController
  before_action :set_device_interest, only: [:show, :edit, :update, :destroy]

  # GET /device_interests
  # GET /device_interests.json
  def index
    @device_interests = DeviceInterest.all
  end

  # GET /device_interests/1
  # GET /device_interests/1.json
  def show
  end

  # GET /device_interests/new
  def new
    @device_interest = DeviceInterest.new
  end

  # GET /device_interests/1/edit
  def edit
  end

  # POST /device_interests
  # POST /device_interests.json
  def create
    @device_interest = DeviceInterest.new(device_interest_params)

    respond_to do |format|
      if @device_interest.save
        format.html { redirect_to @device_interest, notice: 'Device interest was successfully created.' }
        format.json { render :show, status: :created, location: @device_interest }
      else
        format.html { render :new }
        format.json { render json: @device_interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_interests/1
  # PATCH/PUT /device_interests/1.json
  def update
    respond_to do |format|
      if @device_interest.update(device_interest_params)
        format.html { redirect_to @device_interest, notice: 'Device interest was successfully updated.' }
        format.json { render :show, status: :ok, location: @device_interest }
      else
        format.html { render :edit }
        format.json { render json: @device_interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_interests/1
  # DELETE /device_interests/1.json
  def destroy
    @device_interest.destroy
    respond_to do |format|
      format.html { redirect_to device_interests_url, notice: 'Device interest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_interest
      @device_interest = DeviceInterest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_interest_params
      params.require(:device_interest).permit(:device_id, :interest_id)
    end
end
