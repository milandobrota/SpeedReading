class WordPairsController < ApplicationController
  before_filter :authenticate_user!

  # GET /word_pairs
  # GET /word_pairs.json
  def index
    @word_pairs = WordPair.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @word_pairs }
    end
  end

  # GET /word_pairs/1
  # GET /word_pairs/1.json
  def show
    @word_pair = WordPair.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @word_pair }
    end
  end

  # GET /word_pairs/new
  # GET /word_pairs/new.json
  def new
    @word_pair = WordPair.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @word_pair }
    end
  end

  # GET /word_pairs/1/edit
  def edit
    @word_pair = WordPair.find(params[:id])
  end

  # POST /word_pairs
  # POST /word_pairs.json
  def create
    @word_pair = WordPair.new(params[:word_pair])

    respond_to do |format|
      if @word_pair.save
        flash[:notice] = 'Word pair was successfully created.'
        format.html { redirect_to @word_pair }
        format.json { render json: @word_pair, status: :created, location: @word_pair }
      else
        format.html { render action: "new" }
        format.json { render json: @word_pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /word_pairs/1
  # PUT /word_pairs/1.json
  def update
    @word_pair = WordPair.find(params[:id])

    respond_to do |format|
      if @word_pair.update_attributes(params[:word_pair])
        flash[:notice] = 'Word pair was successfully updated.'
        format.html { redirect_to @word_pair }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @word_pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /word_pairs/1
  # DELETE /word_pairs/1.json
  def destroy
    @word_pair = WordPair.find(params[:id])
    @word_pair.destroy

    flash[:notice] = 'Word pair was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to word_pairs_url }
      format.json { head :ok }
    end
  end
end
