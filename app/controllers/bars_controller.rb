class BarsController < ApplicationController
  before_action :authenticate_user!
  autocomplete :ingredient, :name
  before_action :set_bar, only: [:show, :possible, :edit, :update, :destroy]
  before_action :set_user, except: [:index]
  # before_action :owned_bar, except: [:index, :new, :create]
  # GET /bars
  # GET /bars.json
  def index
    @bars = Bar.all
    @user = current_user
    if @bars.exists?
      redirect_to user_bar_path(@user, 1)
    end
  end

  # GET /bars/1
  # GET /bars/1.json
  def show
    if params[:search]
      @ingredients = Ingredient.where("name LIKE ?", "%#{params[:search]}%").order('name')
      respond_to do |format|
        format.js
      end
    else
      @ingredients = Ingredient.where(bar_id: params[:bar_id]).order(in_stock: :desc)
    end
  end
  def possible
    @recipe_ingredients = RecipeIngredient.where(ingredient_id: params[:ingredient_id]).pluck(:recipe_id)
    @recipe_list = @recipe_ingredients.each { |r| Recipe.includes(:r)}
    puts '************************ list'
    puts @recipe_list

    @recipes = @recipe_list.collect {|r| Recipe.find(r)}
        puts '************************ recipe'
    puts @recipes
    # respond_to do |format|
    #   format.js
    # end
    # Recipe.includes(:recipe_ingredients).where(recipe_ingredient: params[:ingredient_id])
  end
  # GET /bars/new
  def new
    @bar = current_user.bars.new
  end

  # GET /bars/1/edit
  def edit
  end

  # POST /bars
  # POST /bars.json
  def create
    @bar = current_user.bars.new(bar_params)

    respond_to do |format|
      if @bar.save
        format.html { render :show, notice: 'Bar was successfully created.' }
        format.json { render :show, status: :created, location: @bar }
      else
        format.html { render :new }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bars/1
  # PATCH/PUT /bars/1.json
  def update
    respond_to do |format|
      if @bar.update(bar_params)
        format.html { redirect_to user_bar_url, notice: 'Bar was successfully updated.' }
        format.json { render :show, status: :ok, location: @bar }
      else
        format.html { render :edit }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bars/1
  # DELETE /bars/1.json
  def destroy
    @bar.destroy
    respond_to do |format|
      format.html { redirect_to user_bar_url, notice: 'Bar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bar
      @bar = Bar.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def owned_bar
      @bar = Bar.find(params[:id])
      unless current_user.id == @bar.user_id
        flash[:alert] = "That bar doesn't belong to you!"
        redirect_to root_path
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def bar_params
      params.require(:bar).permit(:name)
    end
end
