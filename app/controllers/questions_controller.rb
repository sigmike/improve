class QuestionsController < ApplicationController

  before_filter :find_question

  QUESTIONS_PER_PAGE = 20

  def create
    @question = Question.new(params[:question])
    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question was successfully created.'
        format.html { redirect_to @question }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @question.destroy
        flash[:notice] = 'Question was successfully destroyed.'        
        format.html { redirect_to questions_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Question could not be destroyed.'
        format.html { redirect_to @question }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @questions = Question.paginate(:page => params[:page], :per_page => QUESTIONS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @questions }
    end
  end

  def edit
  end

  def new
    @question = Question.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @question }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @question }
    end
  end

  def update
    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to @question }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_question
    @question = Question.find(params[:id]) if params[:id]
  end

end