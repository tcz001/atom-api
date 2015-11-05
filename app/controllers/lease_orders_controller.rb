class LeaseOrdersController < ApplicationController
  before_action :set_lease_order, only: [:show, :edit, :update, :destroy]

  # GET /lease_orders
  # GET /lease_orders.json
  def index
    @lease_orders = LeaseOrder.all
  end

  # GET /lease_orders/1
  # GET /lease_orders/1.json
  def show
  end

  # GET /lease_orders/new
  def new
    @lease_order = LeaseOrder.new
  end

  # GET /lease_orders/1/edit
  def edit
  end

  # POST /lease_orders
  # POST /lease_orders.json
  def create
    @lease_order = LeaseOrder.new(lease_order_params)

    respond_to do |format|
      if @lease_order.save
        format.html { redirect_to @lease_order, notice: 'Lease order was successfully created.' }
        format.json { render :show, status: :created, location: @lease_order }
      else
        format.html { render :new }
        format.json { render json: @lease_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lease_orders/1
  # PATCH/PUT /lease_orders/1.json
  def update
    respond_to do |format|
      if @lease_order.update(lease_order_params)
        format.html { redirect_to @lease_order, notice: 'Lease order was successfully updated.' }
        format.json { render :show, status: :ok, location: @lease_order }
      else
        format.html { render :edit }
        format.json { render json: @lease_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lease_orders/1
  # DELETE /lease_orders/1.json
  def destroy
    @lease_order.destroy
    respond_to do |format|
      format.html { redirect_to lease_orders_url, notice: 'Lease order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lease_order
      @lease_order = LeaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lease_order_params
      params.require(:lease_order).permit(:games_id, :game_versions_id, :third_partys_id, :irb)
    end
end
