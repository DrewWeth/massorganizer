class ServicesController < ApplicationController

  def text
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

      q = params["q"]
      receivers = params["receivers"].to_i

      if receivers == -1
        send_arr = Device.all.map{|x| x.id}
      else
        send_arr = [receivers]
      end

      result[:q] = q
      result[:receivers] = receivers
      result[:send_arr] = send_arr
      result[:sent_to] = []

      send_arr.each do |send|

        device = Device.where(:id=> send.to_i).take
        result[:sent_to].push(device)
        begin

          @client.account.messages.create(
          :from => '+13147363270',
          :to => device.tele,
          :body => q
          )
        rescue Exception => e
          puts e
        end

      result[:result] = "success"
    end
    render :json => result

  end

end
