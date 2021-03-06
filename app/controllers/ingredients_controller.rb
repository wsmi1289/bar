class IngredientsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_ingredient, only: [:show, :edit, :toggle, :update, :destroy]
  before_action :set_bar
  before_action :set_user
  # before_action :owned_by_bar
  # GET /ingredients
  # GET /ingredients.json
  def index
    @user = current_user
    @ingredients = Ingredient.where(bar_id: params[:bar_id])
  end

  def filter
    @ingredients = Ingredient.where(type_id: ingredient_params[:type_id])
    respond_to do |format|
      format.js
    end
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end
  
  def toggle
    respond_to do |format|
      if @ingredient.update_attribute(:in_stock, params[:in_stock])
        format.html { render :show, notice: 'Ingredient was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /ingredients/new
  def new
    @ingredient = @bar.ingredients.new
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    @ingredient = @bar.ingredients.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { render :show, notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to user_bar_ingredients_url, notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to user_bar_ingredients_url, notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    def set_bar
      @bar = Bar.find(params[:bar_id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def ingredient_params
      params.require(:ingredient).permit(:id,:name, :description, :in_stock, :type_id)
    end
end
