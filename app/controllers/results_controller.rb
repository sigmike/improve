class ResultsController < ApplicationController

  before_filter :find_result

  RESULTS_PER_PAGE = 20

  def create
    @result = Result.new(params[:result])
    if @result.question.user_id != current_user.id
      raise ArgumentError, "Invalid question"
    end
    respond_to do |format|
      if @result.save
        flash[:notice] = 'Result was successfully created.'
        format.html { redirect_to @result }
        format.xml  { render :xml => @result, :status => :created, :location => @result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @result.destroy
        flash[:notice] = 'Result was successfully destroyed.'        
        format.html { redirect_to results_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Result could not be destroyed.'
        format.html { redirect_to @result }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @results = Result.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @results }
    end
  end

  def edit
  end

  def new
    @result = Result.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @result }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @result }
    end
  end

  def update
    question = Question.find(params[:result][:question_id])
    if question.user_id != current_user.id
      raise ArgumentError, "Invalid question"
    end
    respond_to do |format|
      if @result.update_attributes(params[:result])
        flash[:notice] = 'Result was successfully updated.'
        format.html { redirect_to @result }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_result
    if params[:id]
      @result = Result.find(params[:id])
      raise ArgumentError, "Invalid result" if @result.question.user_id != current_user.id
    end
  end

end