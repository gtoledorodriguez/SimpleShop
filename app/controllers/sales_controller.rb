class SalesController < ApplicationController
  before_action :set_sale, only: [ :show, :edit, :update, :destroy ]
  before_action :restrict_access, only: [ :edit, :update, :destroy ]

  # GET /sales or /sales.json
  def index
    @sales = current_user.businesses.first.sales.order(created_at: :desc)
  end

  # GET /sales/1 or /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = current_user.businesses.first.sales.new
    @sale.user_id = current_user.id
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales or /sales.json
  def create
    @sale = current_user.businesses.first.sales.new(sale_params)
    @sale.user_id = current_user.id


    respond_to do |format|
      if @sale.save
        flash[:notice] = "Sale was successfully created."

        # Append stock warning if applicable
        if @sale.item.quantity_in_stock <= 0
          flash[:alert] = "Item '#{@sale.item.name}' is now Sold Out!"
        elsif @sale.item.quantity_in_stock <= @sale.item.low_stock_threshold
          flash[:warning] = " ⚠ Item '#{@sale.item.name}' is Low Stock!"
        end

        format.html { redirect_to @sale }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: "Sale was successfully updated." }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    @sale.destroy!

    respond_to do |format|
      format.html { redirect_to sales_path, status: :see_other, notice: "Sale was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sale
    @sale = Sale.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def sale_params
    params.expect(sale: [ :item_id, :user_id, :quantity_sold ])
  end

  # Sends alert restricting access
  def restrict_access
    action = action_name.humanize
    redirect_to root_path, alert: "You cannot access #{action} at this time. Please use void. Void is being implemented."
  end
end
