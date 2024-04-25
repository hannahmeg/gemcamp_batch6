class OrdersController < ApplicationController
  before_action :set_order, only: [:submit, :pay, :fail, :revoke]

  def index
    @orders = Order.all.includes(:user)
  end

  def submit
    if @order.submit!
      redirect_to orders_path, notice: 'Order submitted successfully.'
    else
      redirect_to orders_path, alert: 'Failed to submit order.'
    end
  end

  def pay
    if @order.pay!
      redirect_to orders_path, notice: 'Order paid successfully.'
    else
      redirect_to orders_path, alert: 'Failed to pay order.'
    end
  end

  def fail
    if @order.fail!
      redirect_to orders_path, notice: 'Order failed.'
    else
      redirect_to orders_path, alert: 'Failed to mark order as failed.'
    end
  end

  def revoke
    if @order.revoke!
      redirect_to orders_path, notice: 'Order revoked.'
    else
      redirect_to orders_path, alert: 'Failed to revoke order.'
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
