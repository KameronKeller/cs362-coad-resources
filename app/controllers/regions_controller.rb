class RegionsController < ApplicationController

  before_action :authenticate_user! #ensures user is authenticated, will throw exception on failure (?)x  
  before_action :authenticate_admin #ensures user is a admin
  #^defined in ApplicationController
  #Googling: Can register all kinds of actions to do before the handlers
  #All admins are users: do we need both?


  def index
    @regions = Region.all
  end

  def show
    @region = Region.includes(:tickets).find(params[:id])
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      redirect_to regions_path, notice: 'Region successfully created.'
    else
      render :new
    end
  end

  def edit
    @region = Region.find(params[:id])
  end

  def update
    @region = Region.find(params[:id])
    if @region.update(region_params)
      redirect_to @region, notice: 'Region successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    region = Region.includes(:tickets).find(params[:id])
    delete_region_service = DeleteRegionService.new(region)
    delete_region_service.run!
    redirect_to regions_path, notice: "Region #{region.name} was deleted. Associated tickets now belong to the 'Unspecified' region."
  end

  private

  def region_params
    params.require(:region).permit(:name)
  end

end
