class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @user = current_user
    if user_signed_in?
      if !current_user.admin?
        @orders = @user.orders.all
      else
        @orders = Order.all
      end
    else
      not_an_admin
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @orderitems = Orderitem.where(order_id: params[:id])
  end

  # GET /orders/new
  def new
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      else
        @order = Order.new
      end
    else
      not_an_admin
    end
  end

  # GET /orders/1/edit
  def edit
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      end
    else
      not_an_admin
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if user_signed_in?
      if !current_user.admin?
        not_an_admin
      else
        @order.destroy
        respond_to do |format|
          format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    else
      not_an_admin
    end
  end

  # redirect to orders with a warning message
  def not_an_admin
    redirect_to "/"
    flash[:notice] = 'This page is not accessible'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:order_date, :user_id, :status)
    end
end
