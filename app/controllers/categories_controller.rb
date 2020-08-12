class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      else
        @category = Category.new
      end
    else
      not_an_admin
    end
  end

  # GET /categories/1/edit
  def edit
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      end
    else
      not_an_admin
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      else
        @category.destroy
        respond_to do |format|
          format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    else
      not_an_admin
    end
  end

  # redirect to categories with a warning message
  def not_an_admin
    redirect_to "/categories"
    flash[:notice] = 'This page is not accessible'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:title, :description, :image)
    end
end
