class OrdersController < ApplicationController
  before_action :set_order, only: [:submit, :pay, :fail, :revoke]
  before_action :authenticate_user!
  before_action :validate_admin_role

  def index
    @orders = Order.includes(:user)

    @orders = @orders.order(created_at: params[:sort_by] == "asc" ? :asc : :desc)
    @orders = @orders.page(params[:page]).per(10)
  end

  def submit
    if @order.may_submit? && @order.submit!
      redirect_to orders_path, notice: 'Order submitted successfully.'
    else
      redirect_to orders_path, alert: 'Failed to submit order.'
    end
  end

  def pay
    if @order.may_pay? && @order.pay!
      redirect_to orders_path, notice: 'Order paid successfully.'
    else
      redirect_to orders_path, alert: 'Failed to pay order.'
    end
  end

  def fail
    if @order.may_fail? && @order.fail!
      redirect_to orders_path, notice: 'Order failed.'
    else
      redirect_to orders_path, alert: 'Failed to mark order as failed.'
    end
  end

  def revoke
    if @order.may_revoke? && @order.revoke!
      redirect_to orders_path, notice: 'Order revoked.'
    else
      redirect_to orders_path, alert: 'Failed to revoke order.'
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def validate_admin_role
    unless current_user.role == 'admin'
      flash[:notice] = 'access unauthorized'
      redirect_to posts_path
    end
  end
end
