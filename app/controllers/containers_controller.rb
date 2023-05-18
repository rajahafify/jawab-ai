class ContainersController < ApplicationController
  before_action :set_container, only: %i[ show edit update destroy ]

  before_action :set_factory

  # GET /containers or /containers.json
  def index
    @containers = @factory.containers.all
  end

  # GET /containers/1 or /containers/1.json
  def show
  end

  # GET /containers/new
  def new
    @container = @factory.containers.new
  end

  # GET /containers/1/edit
  def edit
  end

  # POST /containers or /containers.json
  def create
    @container = @factory.containers.new(container_params)

    respond_to do |format|
      if @container.save
        format.html { redirect_to [@factory, @container], notice: "Container was successfully created." }
        format.json { render :show, status: :created, location: @container }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /containers/1 or /containers/1.json
  def update
    respond_to do |format|
      if @container.update(container_params)
        format.html { redirect_to [@factory, @container], notice: "Container was successfully updated." }
        format.json { render :show, status: :ok, location: @container }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /containers/1 or /containers/1.json
  def destroy
    @container.destroy

    respond_to do |format|
      format.html { redirect_to factory_url(@factory), notice: "Container was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_container
      @container = Container.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def container_params
      params.require(:container).permit(:name, :description, :factory_id)
    end

    def set_factory
      @factory = Factory.find(params[:factory_id])
    end
end