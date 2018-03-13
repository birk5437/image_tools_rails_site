class ImageProcessorsController < ApplicationController
  # before_filter :redirect_unless_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_image_processor, only: [:show, :edit, :update, :destroy, :vote]
  respond_to :js, :only => [:create, :update, :destroy]

  # GET /image_processors
  # GET /image_processors.json
  def index
    # TODO: replace sort_order with acts_as_votable
    @image_processors = ImageProcessor.all.order("created_at desc")

    respond_to do |format|
      format.html
      format.json { render json: @image_processors }
    end

  end

  # GET /image_processors/1
  # GET /image_processors/1.json
  def show
  end

  # GET /image_processors/new
  def new
    @image_processor = ImageProcessor.new
    @image_processors = ImageProcessor.all.order("created_at desc")
  end

  # GET /image_processors/1/edit
  def edit
  end

  # POST /image_processors
  # POST /image_processors.json
  def create
    # raise "test"
    @image_processors = ImageProcessor.all.order("created_at desc")
    @image_processor = ImageProcessor.new(image_processor_params)

    respond_to do |format|
      if @image_processor.save
        format.html { redirect_to @image_processor, notice: 'ImageProcessor was successfully created.' }
        format.json { render json: @image_processor}
        format.js{ render :create }
      else
        format.html { render :new }
        format.json { render json: @image_processor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_processors/1
  # PATCH/PUT /image_processors/1.json
  def update
    @image_processors = ImageProcessor.all.order("created_at desc")
    respond_to do |format|
      if @image_processor.update(image_processor_params)
        format.html { redirect_to @image_processor, notice: 'ImageProcessor was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_processor }
        format.js{ render :create }
      else
        format.html { render :edit }
        format.json { render json: @image_processor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_processors/1
  # DELETE /image_processors/1.json
  def destroy
    @image_processor.destroy
    respond_to do |format|
      format.html { redirect_to image_processors_url, notice: 'ImageProcessor was successfully destroyed.' }
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

    @image_processor.vote_by voter: current_user, vote: direction

    redirect_to action: :index
  end

  private ##################################################################################################################################

  # TODO: use declarative_authorization gem when roles/CRUD gets more complex
  def redirect_unless_admin
    redirect_to root_path unless current_user && current_user.admin?
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_image_processor
      @image_processor = ImageProcessor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_processor_params
      params[:image_processor] ||= {}
      ImageProcessor::TYPES.each do |t|
        params_for_polymorphic_type = params.delete(t.gsub("::", "").underscore.to_sym) || {}
        params_for_polymorphic_type.each do |k,v|
          params[:image_processor][k] = v 
        end
      end
      params.require(:image_processor).permit(:type, :source_image, :processed_image)
    end
end
