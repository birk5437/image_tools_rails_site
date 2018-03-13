class LotionsController < ApplicationController
  before_filter :redirect_unless_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_lotion, only: [:show, :edit, :update, :destroy, :vote]

  # GET /lotions
  # GET /lotions.json
  def index
    # TODO: replace sort_order with acts_as_votable
    @lotions = Lotion.all.order("created_at desc")

    respond_to do |format|
      format.html
      format.json { render json: @lotions }
    end

  end

  # GET /lotions/1
  # GET /lotions/1.json
  def show
  end

  # GET /lotions/new
  def new
    @lotion = Lotion.new
  end

  # GET /lotions/1/edit
  def edit
  end

  # POST /lotions
  # POST /lotions.json
  def create
    @lotion = Lotion.new(lotion_params)
    @lotion.created_by = current_user

    respond_to do |format|
      if @lotion.save
        format.html { redirect_to @lotion, notice: 'Lotion was successfully created.' }
        format.json { render :show, status: :created, location: @lotion }
      else
        format.html { render :new }
        format.json { render json: @lotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lotions/1
  # PATCH/PUT /lotions/1.json
  def update
    respond_to do |format|
      if @lotion.update(lotion_params)
        format.html { redirect_to @lotion, notice: 'Lotion was successfully updated.' }
        format.json { render :show, status: :ok, location: @lotion }
      else
        format.html { render :edit }
        format.json { render json: @lotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lotions/1
  # DELETE /lotions/1.json
  def destroy
    @lotion.destroy
    respond_to do |format|
      format.html { redirect_to lotions_url, notice: 'Lotion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  #->Prelang (voting/acts_as_votable)
  def vote

    direction = params[:direction]

    # Make sure we've specified a direction
    raise "No direction parameter specified to #vote action." unless direction

    # Make sure the direction is valid
    unless ["like", "bad"].member? direction
      raise "Direction '#{direction}' is not a valid direction for vote method."
    end

    @lotion.vote_by voter: current_user, vote: direction

    redirect_to action: :index
  end

  private ##################################################################################################################################

  # TODO: use declarative_authorization gem when roles/CRUD gets more complex
  def redirect_unless_admin
    redirect_to root_path unless current_user && current_user.admin?
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_lotion
      @lotion = Lotion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lotion_params
      params.require(:lotion).permit(:name, :description, :image1, :image2, :hotel_ids => [])
    end
end
