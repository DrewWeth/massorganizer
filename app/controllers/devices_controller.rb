class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]



  skip_before_filter  :verify_authenticity_token
  protect_from_forgery with: :null_session


  def message
    require 'twilio-ruby'

    result = {}

    puts "Twilio authentication"
    account_sid = 'AC29e7b96239c5f0bfc6ab8b724e263f30'
    auth_token = 'e9befab8a2ea884e92db21709fe073e1'
    begin
      @client = Twilio::REST::Client.new account_sid, auth_token
    rescue Twilio::RESR::RequestError => e
      puts e.message
    end


    message_body = params["Body"]
    from_number = params["From"]

    if message_body.downcase.index("usage")
      interests = Interest.all.map{|x| x.name + " (" + x.id.to_s + ")" }.join(", ")
      begin
        result[:interests] = interests
        @client.account.messages.create(
        :from => '+13147363270',
        :to => from_number,
        :body => 'Usage: Text "Your name (your pawprint) list of interests". Example: "Drew (agwrnd) 1,2,4". The interests are: ' + interests
        )
      rescue Exception => e
        puts e
      end
    else


      device = get_device(from_number)


      matches = message_body.scan(/((?:[0-9]+,?)+)/)


      result[:matches] = matches


      matches.each do |match|
        match = match.first

        puts match
        match.split(",").each do |interest|
          puts interest
          puts DeviceInterest.create(:device_id => device.id, :interest_id => interest)
        end
      end

      message = ""

      if device.name == nil

        name = message_body.scan(/^[^\(]+/).first.strip

        result[:name] = name
        result[:device] = device.update(:name => name)
        message += "Your name is " + name.to_s + ". "
      end

      if device.pawprint == nil

        pawprint = message_body.scan(/\(([^)]*)\)/).first.first

        result[:pawprint] = pawprint
        device.update(:pawprint => pawprint.to_s)
        message += "Your pawprint is: " + pawprint.to_s + ". "
      end

      if interests = device.interests

        message += "You are now subscribed to "
        message += interests.map(&:name).join(", ")
        message += ". Thanks!"
      end


      begin

        @client.account.messages.create(
        :from => '+13147363270',
        :to => from_number,
        :body => message
        )
      rescue Exception => e
        puts e
      end
    end
    result[:result] = "success"
    render :json => result
  end






  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    @interests = @device.interests
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def get_device(from_number)
      if device = Device.where(tele: from_number.to_s).take

      else
        device = Device.create(tele: from_number)
      end

      return device
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:tele, :pawprint, :name)
    end
end
