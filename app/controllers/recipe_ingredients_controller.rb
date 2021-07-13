class RecipeIngredientsController < ApplicationController
  # before_action :authenticate_user!
  autocomplete :ingredient, :name
  before_action :set_recipe_ingredient, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :set_bar

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  # POST /recipe_ingredients
  # POST /recipe_ingredients.json
  def create
    @ingredients = Ingredient.where(bar_id: params[:bar_id], in_stock: true)
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)

    respond_to do |format|
      if @recipe_ingredient.save
        format.html { redirect_to user_bar_recipes_path, notice: 'Recipe ingredient was successfully created.' }
        format.json { redirect_to user_bar_recipes_path, status: :created, location: @recipe_ingredient }
      else
        format.html { redirect_to user_bar_recipes_path }
        format.json { render json: @recipe_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_ingredients/1
  # DELETE /recipe_ingredients/1.json
  def destroy
    @recipe_ingredient.destroy
    respond_to do |format|
      format.html { render :index, notice: 'Recipe ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_ingredient
      @recipe_ingredient = RecipeIngredient.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def get_autocomplete_items(parameters)
      items = active_record_get_autocomplete_items(parameters)
      items = items.where(bar_id: params[:bar_id], in_stock: true)
    end

    def set_bar
      @bar = Bar.find(params[:bar_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_ingredient_params
      params.require(:recipe_ingredient).permit(:quantity, :ingredient_id)
    end
end
