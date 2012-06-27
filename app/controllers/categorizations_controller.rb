class CategorizationsController < ApplicationController
  # GET /categorizations
  # GET /categorizations.json
  def index
    @categorizations = Categorization.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categorizations }
    end
  end

  # GET /categorizations/1
  # GET /categorizations/1.json
  def show
    @categorization = Categorization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @categorization }
    end
  end

  # GET /categorizations/new
  # GET /categorizations/new.json
  def new
    @categorization = Categorization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @categorization }
    end
  end

  # GET /categorizations/1/edit
  def edit
    @categorization = Categorization.find(params[:id])
  end

  # POST /categorizations
  # POST /categorizations.json
  def create
    @categorization = Categorization.new(params[:categorization])

    respond_to do |format|
      if @categorization.save
        format.html { redirect_to @categorization, notice: 'Categorization was successfully created.' }
        format.json { render json: @categorization, status: :created, location: @categorization }
      else
        format.html { render action: "new" }
        format.json { render json: @categorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categorizations/1
  # PUT /categorizations/1.json
  def update
    @categorization = Categorization.find(params[:id])

    respond_to do |format|
      if @categorization.update_attributes(params[:categorization])
        format.html { redirect_to @categorization, notice: 'Categorization was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @categorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categorizations/1
  # DELETE /categorizations/1.json
  def destroy
    @categorization = Categorization.find(params[:id])
    @categorization.destroy

    respond_to do |format|
      format.html { redirect_to categorizations_url }
      format.json { head :ok }
    end
  end
end
