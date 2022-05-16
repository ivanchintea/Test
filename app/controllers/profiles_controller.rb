class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def scrape
    @profile = Profile.get_from(url: params[:source] )

    if @profile
      respond_to do |format|
        format.html { render :action => "edit", :notice => 'Profile was successfully scraped' }
      end
    end
  end

  def create
    @profile = Profile.new(strong_params)
    respond_to do |format|
      if @profile.save
        format.html { redirect_to(@profile, :notice => 'Profile was successfully extracted') }
      else
        format.html  { render :action => "new", :notice => 'There is no profile in this source' }
      end
    end
  end

  def update
    @profile = Profile.find(params[:id])
    respond_to do |format|
      if @profile.update(strong_params)
        format.html { redirect_to edit_profile_path, :notice => 'Profile was successfully updated' }
      else
        format.html { redirect_to edit_profile_path, :notice => 'Profile was not successfully updated' }
      end
    end
  end

  def edit
    if params[:id]
      @profile = Profile.find(params[:id])
    end
  end

  private
  def strong_params
    params.require(:profile).permit(:first_name, :last_name, :country, :native_language, :target_language, :source)
  end

end

