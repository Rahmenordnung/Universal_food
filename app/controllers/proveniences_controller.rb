class ProveniencesController < ApplicationController
  before_action :set_provenience, only: [:show, :edit, :update, :destroy]

  # GET /proveniences
  # GET /proveniences.json
  def index
    @proveniences = Provenience.all
  end

  # GET /proveniences/1
  # GET /proveniences/1.json
  def show
  end

  # GET /proveniences/new
  def new
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      else
        @provenience = Provenience.new
      end
    else
      not_an_admin
    end
  end

  # GET /proveniences/1/edit
  def edit
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      end
    else
      not_an_admin
    end
  end

  # POST /proveniences
  # POST /proveniences.json
  def create
    @provenience = Provenience.new(provenience_params)

    respond_to do |format|
      if @provenience.save
        format.html { redirect_to @provenience, notice: 'Provenience was successfully created.' }
        format.json { render :show, status: :created, location: @provenience }
      else
        format.html { render :new }
        format.json { render json: @provenience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proveniences/1
  # PATCH/PUT /proveniences/1.json
  def update
    respond_to do |format|
      if @provenience.update(provenience_params)
        format.html { redirect_to @provenience, notice: 'Provenience was successfully updated.' }
        format.json { render :show, status: :ok, location: @provenience }
      else
        format.html { render :edit }
        format.json { render json: @provenience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proveniences/1
  # DELETE /proveniences/1.json
  def destroy
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      else
        @provenience.destroy
        respond_to do |format|
          format.html { redirect_to proveniences_url, notice: 'Provenience was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    else
      not_an_admin
    end
  end

  # redirect to proveniences with a warning message
  def not_an_admin
    redirect_to "/proveniences"
    flash[:notice] = 'This page is not accessible'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provenience
      @provenience = Provenience.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def provenience_params
      params.require(:provenience).permit(:title, :description, :image)
    end
end
