class DeviceSubmissionsController < ApplicationController
  before_action :set_device_submission, only: [:show, :edit, :update, :destroy]

  # GET /device_submissions
  # GET /device_submissions.json
  def index
    @device_submissions = DeviceSubmission.all
  end

  # GET /device_submissions/1
  # GET /device_submissions/1.json
  def show
  end

  # GET /device_submissions/new
  def new
    @device_submission = DeviceSubmission.new
  end

  # GET /device_submissions/1/edit
  def edit
  end

  # POST /device_submissions
  # POST /device_submissions.json
  def create
    @device_submission = DeviceSubmission.new(device_submission_params)

    respond_to do |format|
      if @device_submission.save
        format.html { redirect_to @device_submission, notice: 'Device submission was successfully created.' }
        format.json { render :show, status: :created, location: @device_submission }
      else
        format.html { render :new }
        format.json { render json: @device_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_submissions/1
  # PATCH/PUT /device_submissions/1.json
  def update
    respond_to do |format|
      if @device_submission.update(device_submission_params)
        format.html { redirect_to @device_submission, notice: 'Device submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @device_submission }
      else
        format.html { render :edit }
        format.json { render json: @device_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_submissions/1
  # DELETE /device_submissions/1.json
  def destroy
    @device_submission.destroy
    respond_to do |format|
      format.html { redirect_to device_submissions_url, notice: 'Device submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_submission
      @device_submission = DeviceSubmission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_submission_params
      params.require(:device_submission).permit(:device_id, :message)
    end
end
