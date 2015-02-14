class ServicesController < ApplicationController

  def text
      require 'twilio-ruby'

      result = {}

      puts "Twilio authentication"
      account_sid = 'AC29e7b96239c5f0bfc6ab8b724e263f30'
      auth_token = '77d93608f97102a6011bb3fd90229a85'
      begin
        @client = Twilio::REST::Client.new account_sid, auth_token
      rescue Twilio::RESR::RequestError => e
        puts e.message
      end

      q = params["q"]


      interest = params["receivers"]
      send_arr = Interest.find(interest).devices



      result[:send_count] = send_arr.count
      result[:q] = q

      result[:send_arr] = send_arr

      result[:sent_to] = []

      send_arr.each do |send|

        result[:sent_to].push(send)
        begin

          @client.account.messages.create(
          :from => '+13147363270',
          :to => send.tele,
          :body => q
          )
        rescue Exception => e
          puts e
        end

      result[:result] = "success"
    end
    render :json => result

  end

  def priv
    notice = "Failed. Privs not changed."
    if current_user.has_role? :admin
      if user = User.where(:email => params[:user]).take and current_user.id != user.id
        user.admin = params[:priv]
        if user.save
          notice = "Success! Privs changed."
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: notice }
      format.json { head :no_content }
    end
  end

end
