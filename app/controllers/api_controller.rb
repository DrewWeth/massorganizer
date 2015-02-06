class ApiController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]



  skip_before_filter  :verify_authenticity_token
  protect_from_forgery with: :null_session

  require 'twilio-ruby'



  def message
    result = {}

    message_body = params["Body"]
    from_number = params["From"]

    device = get_device(from_number)
    result[:device] = device

    result[:setup] = ensure_setup(device, message_body)

    result[:analyze] = analyze_text(device, message_body)

    device.save

    render :json => result

  end
  private

    def get_device(from_number)
      if !device = Device.where(tele: from_number.to_s).take
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
      params.require(:device).permit(:tele, :pawprint, :name, :email, :current_org)
    end

    def get_name(device, message_body)
      device.name = message_body
      prompt_for_email(device.tele)
      return true
    end

    def get_email(device, message_body)
      device.email = message_body
      prompt_welcome_message(device.tele)

      # prompt_for_org(device.tele)
      return true
    end

    def prompt_welcome_message(tele)
      message = "Welcome to MCA! If you have any questions, comments, or concerns email Drew at agwrnd@mail.missouri.edu"
      send_text(tele, message)
    end

    def get_org(device, message_body)
      if org = Organization.where(:id => message_body).take
        device.current_org = org.id
      else
        prompt_for_org(device.tele)
      end
    end

    def prompt_for_email(tele)
      message = "Great! Now enter your email address:"
      send_text(tele, message)
      return message
    end


    def prompt_for_org(tele)
      message = "Please enter your organization's ID."
      send_text(tele, message)
      return message
    end

    def prompt_for_name(tele)
      message = "Please enter your name."
      send_text(tele, message)
      return message
    end


    def usage?(device, message_body)
      # Regex for usage stuff
      # if message_body.downcase.include?("usage")
      #   message = ""
      #   send_text(device.tele, message)
      # end
    end

    def send_text(tele, message)
      # Message composition

      puts "Twilio authentication"
      account_sid = 'AC29e7b96239c5f0bfc6ab8b724e263f30'
      auth_token = '77d93608f97102a6011bb3fd90229a85'
      begin
        @client = Twilio::REST::Client.new account_sid, auth_token
      rescue Twilio::RESR::RequestError => e
        puts e.message
      end

      begin
        @client.account.messages.create(
        :from => '+13147363270',
        :to => tele,
        :body => message
        )

      rescue Exception => e
        puts e
      end
    end

    def ensure_setup(device, message_body)
      setup = {}
      if device.name == nil # If it's a new device, continue
        if !get_name(device, message_body) # If you didn't get their name, then ask for it.
          setup[:stage] = prompt_for_name(device.tele)
          return setup
        end

      elsif device.email == nil
        if !get_email(device, message_body) # If you couldn't find email

          setup[:stage] = prompt_for_email(device.tele)
          return setup
        end

      # elsif device.current_org == nil
      #   if !get_org(device, message_body) # If you couldn't find org ID
      #
      #     setup[:stage] = prompt_for_org(device.tele)
      #   end
      else
        setup[:stage] = "Complete"
      end

      return setup
    end

    def switch?(device, message_body)
      # Regex for usage stuff
      if message_body.downcase.include?("switch")
        message = "Implement switch"

        send_text(device.tele, message)
      end
    end

    def interests?(device, message_body)
      #Regex for interests
      list = message_body.strip.split(',')
      list.each do |l|
        DeviceInterest.create(:device_id => device.id, :interest_id => l.to_i)
      end

      interests = get_devices_interest_for_org(device)
      message = "You're not subscribed to " + interests.join(', ')
    end

    def get_devices_interest_for_org(device)
      return device.interests
    end


    def get_devices_interest(device)
      if interests = device.interests
        message += "You are now subscribed to "
        message += interests.map(&:name).join(", ")
        message += ". Thanks!"
      end
    end

    def analyze_text(device, message_body)
      result = {}

      # usage?(device, message_body)

      # switch?(device, message_body) # Switch organization

      # interests?(device, message_body)
      return result
    end




end
