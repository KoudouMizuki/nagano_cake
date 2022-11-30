class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart_items = current_customer.cart_items
    if @cart_items.empty?
      redirect_to cart_items_path
    end
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_number] == "2"
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_number] == "3"
    end
    @cart_items = current_customer.cart_items.all
    @order.postage = 800

    render :confirm
  end

  def create
    @order = current_customer.orders.new(order_params)
    cart_items = current_customer.cart_items
    if @order.save
      cart_items.each do |cart_item|
        order_dateil = OrderDateil.new
        order_dateil.item_id = cart_item.item_id
        order_dateil.order_id = @order.id
        order_dateil.amount = cart_item.amount
        order_dateil.purchase_price = cart_item.item.price
        order_dateil.production_status = 0
        order_dateil.save
      end
      redirect_to orders_thanx_path
      cart_items.destroy_all
    else
      @order.new(order_params)
      render :new
    end
  end

  def index
    @orders = current_customer.orders
  end

  def thanx
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:peyment_type, :postal_code, :address, :name, :postage, :peyment_amount, :order_status)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end
