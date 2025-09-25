class ItemsController < ApplicationController
  before_action :set_item, only: [ :edit, :update, :destroy ]

  # GET /items or /items.json
  def index
    @items = Item.joins(:business).where(businesses: { owner_id: current_user.id }).order(:name)
  end

  # GET /items/1 or /items/1.json
  def show
    @item = Item.find(params[:id])
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.business = current_user.businesses.first # assign user's first business
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    # NOTE: Would love to see business logic in the model, keeping the controllers/views clean 
    @item.business = current_user.businesses.first # assign user's first business

    # Set nil fields to 0
    @item.price ||= 0
    @item.quantity_in_stock ||= 0
    @item.low_stock_threshold ||= 0

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    # Before updating, ensure nil fields become 0
    params[:item][:price] = 0 if params[:item][:price].nil?
    params[:item][:quantity_in_stock] = 0 if params[:item][:quantity_in_stock].nil?
    params[:item][:low_stock_threshold] = 0 if params[:item][:low_stock_threshold].nil?

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy!

    respond_to do |format|
      format.html { redirect_to items_path, status: :see_other, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.expect(item: [ :business_id, :name, :price, :quantity_in_stock, :low_stock_threshold, :sales_count ])
  end
end
