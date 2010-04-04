class ActivitiesController < ApplicationController

  before_filter :find_activity

  ACTIVITIES_PER_PAGE = 20

  def create
    attributes = params[:activity].dup
    attributes[:user_id] = current_user.id
    @activity = Activity.new(attributes)
    respond_to do |format|
      if @activity.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to @activity }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @activity.destroy
        flash[:notice] = 'Activity was successfully destroyed.'        
        format.html { redirect_to activities_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Activity could not be destroyed.'
        format.html { redirect_to @activity }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @activities = Activity.paginate(:page => params[:page], :per_page => ACTIVITIES_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @activities }
    end
  end

  def edit
  end

  def new
    @activity = Activity.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @activity }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @activity }
    end
  end

  def update
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        flash[:notice] = 'Activity was successfully updated.'
        format.html { redirect_to @activity }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_activity
    @activity = Activity.find(params[:id]) if params[:id]
  end

end