class ApiController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]



  skip_before_filter  :verify_authenticity_token
  protect_from_forgery with: :null_session

  require 'twilio-ruby'


  def message
    result = {}

    message_body = params["Body"].strip
    from_number = params["From"].strip

    device = get_device(from_number)

    save_message(device, message_body)

    result[:device] = device

    if ensure_setup(device, message_body)

      result[:analyze] = analyze_text(device, message_body)
    end
    device.save

    flash[:alert] = "Message Sent. Check your phone!"
    redirect_to :back

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


    def save_message(device, message_body)
      DeviceLog.create(:device_id => device.id, :message=>message_body, :from=>device.tele)
    end

    def get_name(device, message_body)
      device.name = message_body
      prompt_for_email(device)
      return true
    end

    def get_email(device, message_body)
      device.email = message_body

      prompt_for_org(device)
      return true
    end

    def prompt_welcome_message(device)
      org = Organization.find(device.current_org)
      leader_email = org.user.email
      message = "Welcome to " + org.name + "! If you have any questions, comments, or concerns email " + leader_email + ". If the organization leader has set up interests, you may list them now!"
      send_text(device, message)
    end

    def get_org(device, message_body)
      if org = Organization.where(:org_key => message_body.strip).take
        a = DeviceMembership.create(:device_id=>device.id, :organization_id=>org.id) # Add to org
        if a.id != nil
          device.current_org = org.id # Set current org
          prompt_welcome_message(device)
        else
          message = "You are already in " + org.name
          send_text(device, message)
          # already in it
        end
        return true
      else
        prompt_again_for_org(device)
        return false
      end
    end

    def prompt_for_email(device)
      message = "Great! Now enter your email address:"
      send_text(device, message)
      return message
    end


    def prompt_for_org(device)
      message = "Please enter your organization's ID."
      send_text(device, message)
      return message
    end

    def prompt_again_for_org(device)
      message = "That doesn't seem to be correct. Ask your organization leader what the secret key is, then text it here!"
      send_text(device, message)
      return message
    end

    def prompt_for_name(device)
      message = "Please enter your name."
      send_text(device, message)
      return message
    end



    def send_text(device, message)
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
        :to => device.tele,
        :body => message
        )

        DeviceLog.create(:device_id=>device.id, :message=>message, :to=>device.tele, :from=>'13147363270')

      rescue Exception => e
        puts e
      end
    end

    def ensure_setup(device, message_body)
      setup = false

      if device.name == nil # If it's a new device, continue
        if !get_name(device, message_body) # If you didn't get their name, then ask for it.
          prompt_for_name(device)
        end
      elsif device.email == nil
        if !get_email(device, message_body) # If you couldn't find email
          prompt_for_email(device)
        end
      elsif device.current_org == nil
        if !get_org(device, message_body) # If you couldn't find org ID
          prompt_for_org(device.tele)
        end
      else
        setup = true
      end

      return setup
    end

    def switch?(device, message_body)
      # Regex for usage stuff
      if message_body.downcase.include?("switch")
        org_name = message_body[/\s.+/]
        if !org_name.nil?
          org_name = org_name.strip
          if org = Organization.where("name like ?", org_name).take
            if DeviceMembership.where(:organization_id => org.id, :device_id => device.id).take
              if device.current_org == org.id
                send_text(device, "You are already focused on " + org.name)
              else
                device.current_org = org.id
                send_text(device, "You have switched to focus to " + org.name)
              end
            else
              send_text(device, "You don't seem to be a member of " + org.name + ". You can try joining by saying \"join " + org.name.upcase + "'s_SECRET_CODE\"")
            end
          else
            send_text(device, "Can't seem to find an organization named " + org_name)
          end
        else
          memberships = device.organizations.map{|x| x.name}.join(', ')
          send_text(device, "Please specify the name of the organization to switch to. You have membership(s) in: " + memberships + ". \n\njoin CLUB_NAME")
        end
        return true
      end
      return false
    end

    def join?(device, message_body)
      # Regex for usage stuff
      if message_body.downcase.include?("join")
        secret_key = message_body[/\s.+/]
        get_org(device, secret_key)
        return true
      else
        return false
      end
    end

    def usage?(device, message_body)
      if message_body.downcase.include?("usage")
        message = "You can:\n\n'join' different orgs\n'switch' between orgs\nlist interests"
        send_text(device, message)
        return true
      else
        return false
      end
    end


    def interests?(device, message_body)
      #Regex for interests
      list = message_body[/(\d+)(,\s*\d+)*/]
      if !list.blank?
        list_arr = list.split(', ')
      else
        list_arr =[]
      end

      already = []
      new_interests = []
      failed = []

      message = ""
      list_arr.each do |l|
        if interest = Interest.where(:organization_id => device.current_org, :rel_interest_id => l.to_i).take
          new_int = DeviceInterest.create(:device_id => device.id, :interest_id => interest.id, :organization_id=> device.current_org)
          if new_int.id != nil
            new_interests << new_int.interest.name
          else
            already << interest.name
          end
        else
          failed << l
        end
      end

      if new_interests.length > 0
        message << "You're subscribed to " + new_interests.join(', ') + ". "
      end

      if already.length > 0
        message << "You're already subscribed to " + already.join(', ') + ". "
      end

      if failed.length > 0
        message << "Failed to subscribe to " + failed.join(', ') + ". Thanks!"
      end

      if !message.blank?
        send_text(device, message)
        return true
      else
        return false
      end

    end

    def get_devices_interest_for_org(device)
      return DeviceInterest.where(:device_id => device.id, :organization_id => device.current_org).map{|x| x.interest.name}
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

      if result[:usage] = usage?(device, message_body)
      elsif result[:join] = join?(device, message_body)
      elsif result[:switch] = switch?(device, message_body) # Switch organization
      elsif result[:response] = interests?(device, message_body)
      else
        result[:error] = send_text(device, "Not sure what you mean.. but you can say \"usage\" to help!")
      end
      return result
    end

end
