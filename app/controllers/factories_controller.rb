class FactoriesController < ApplicationController
  before_action :set_factory, only: %i[ show edit update destroy ]

  # GET /factories or /factories.json
  def index
    @factories = Factory.all
  end

  # GET /factories/1 or /factories/1.json
  def show
  end

  # GET /factories/new
  def new
    @factory = Factory.new
  end

  # GET /factories/1/edit
  def edit
  end

  # POST /factories or /factories.json
  def create
    @factory = Factory.new(factory_params)

    respond_to do |format|
      if @factory.save
        format.html { redirect_to factory_url(@factory), notice: "Factory was successfully created." }
        format.json { render :show, status: :created, location: @factory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @factory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /factories/1 or /factories/1.json
  def update
    respond_to do |format|
      if @factory.update(factory_params)
        format.html { redirect_to factory_url(@factory), notice: "Factory was successfully updated." }
        format.json { render :show, status: :ok, location: @factory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @factory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /factories/1 or /factories/1.json
  def destroy
    @factory.destroy

    respond_to do |format|
      format.html { redirect_to factories_url, notice: "Factory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_factory
      @factory = Factory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def factory_params
      params.require(:factory).permit(:name, :description, :url)
    end
end
