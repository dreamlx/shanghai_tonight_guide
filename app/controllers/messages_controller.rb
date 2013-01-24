class MessagesController < ApplicationController
  before_filter :authenticate_user!
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end
  
  #get member
  def send_me
    @message = Message.find(params[:id])
    #APNS.host = 'gateway.push.apple.com' 
    # gateway.sandbox.push.apple.com is default

    APNS.pem  = Rails.root.to_s + "/public/certification/cert.pem"
    # this is the file you just created
    
    APNS.port = 2195 
    # this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.
    # send
    
    device_tokens = Device.all
    device_tokens.each do|device_token|
      #device_token = "d5c46e49 01412d0d 749c2721 389887d9 798f58b3 daab240a 8e789129 4eccf9e8"
      unless device_token.desc.nil?
        APNS.send_notification(device_token.desc, @message.title + ": " + @message.body) 
      end
    end
    redirect_to @message, notice: 'Message was successfully created.'
  end
  
  
  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
