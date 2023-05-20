class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy ]
  before_action :set_factory
  before_action :set_container

  # GET /entries/1 or /entries/1.json
  def show
    @entry = @container.entries.find(params[:id])
  end

  # GET /entries/new
  def new
    @entry = @container.entries.new
  end

  # GET /entries/1/edit
  def edit
    @entry = @container.entries.find(params[:id])
  end

  # POST /entries or /entries.json
  def create
    @entry = @container.entries.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to [@factory, @container, @entry], notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to [@factory, @container, @entry], notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to [@factory, @container], notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(:title, :content, :container_id)
    end

    def set_factory
      @factory = Factory.find(params[:factory_id])
    end

    def set_container
      @container = @factory.containers.find(params[:container_id])
    end
end
