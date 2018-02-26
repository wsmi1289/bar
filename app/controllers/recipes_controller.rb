class RecipesController < ApplicationController
  # before_action :authenticate_user!
  autocomplete :ingredient, :name, ful: true
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :set_bar
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  def possible
    @ingredients = RecipeIngredient.where(recipe_id: params[:id])
  end
  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @ingredients = RecipeIngredient.where(recipe_id: params[:id])
    respond_to do |format|
      format.js
    end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to user_bar_recipes_url, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    @recipes = Recipe.all
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to user_bar_recipes_url, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to user_bar_recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_bar
      @bar = Bar.find(params[:bar_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:id, :name, :directions, recipe_ingredients_attributes:[:id, :quantity, :ingredient_id, :recipe_id, :_destroy])
    end
end
