class BarsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_bar, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  # before_action :owned_bar, except: [:index, :new, :create]
  # GET /bars
  # GET /bars.json
  def index
    @bars = Bar.where(user_id: current_user.id)
  end

  # GET /bars/1
  # GET /bars/1.json
  def show
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
      @user = User.find(current_user.id)
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
