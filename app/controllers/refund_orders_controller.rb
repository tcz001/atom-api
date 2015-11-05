class RefundOrdersController < ApplicationController
  before_action :set_refund_order, only: [:show, :edit, :update, :destroy]

  # GET /refund_orders
  # GET /refund_orders.json
  def index
    @refund_orders = RefundOrder.all
  end

  # GET /refund_orders/1
  # GET /refund_orders/1.json
  def show
  end

  # GET /refund_orders/new
  def new
    @refund_order = RefundOrder.new
  end

  # GET /refund_orders/1/edit
  def edit
  end

  # POST /refund_orders
  # POST /refund_orders.json
  def create
    @refund_order = RefundOrder.new(refund_order_params)

    respond_to do |format|
      if @refund_order.save
        format.html { redirect_to @refund_order, notice: 'Refund order was successfully created.' }
        format.json { render :show, status: :created, location: @refund_order }
      else
        format.html { render :new }
        format.json { render json: @refund_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /refund_orders/1
  # PATCH/PUT /refund_orders/1.json
  def update
    respond_to do |format|
      if @refund_order.update(refund_order_params)
        format.html { redirect_to @refund_order, notice: 'Refund order was successfully updated.' }
        format.json { render :show, status: :ok, location: @refund_order }
      else
        format.html { render :edit }
        format.json { render json: @refund_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /refund_orders/1
  # DELETE /refund_orders/1.json
  def destroy
    @refund_order.destroy
    respond_to do |format|
      format.html { redirect_to refund_orders_url, notice: 'Refund order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_refund_order
      @refund_order = RefundOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def refund_order_params
      params.require(:refund_order).permit(:third_party_id, :third_pary_id, :payment_account, :mobile, :customer_name, :why, :status)
    end
end
