class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all.paginate(page: params[:page], per_page: 6)
    
    @categories = Category.all
    
    @proveniences = Provenience.all
    
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      else
        @item = Item.new
      end
    else
      not_an_admin
    end
  end

  # GET /items/1/edit
  def edit
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      end
    else
      not_an_admin
    end
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      else
        respond_to do |format|
          if @item.update(item_params)
            format.html { redirect_to @item, notice: 'Item was successfully updated.' }
            format.json { render :show, status: :ok, location: @item }
          else
            format.html { render :edit }
            format.json { render json: @item.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      not_an_admin
    end
  end
  
  
    def search
     st = "%#{params[:q]}%"
     @items = Item.where("title like ? or description like ? or category like ? or provenience like ? or price like ? " , st, st, st, st, st).paginate(page: params[:page], per_page: 10)
    end


  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      else
        @item.destroy
        respond_to do |format|
          format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    else
      not_an_admin
    end
  end

  # redirect to products with a warning message
  def not_an_admin
    redirect_to "/products"
    flash[:notice] = 'This page is not accessible'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url, :category, :provenience, :inStock)
    end
end
