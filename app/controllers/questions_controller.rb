class QuestionsController < ApplicationController

  def index
    if params[:query].present?
      @questions = Question.where("query ILIKE ?", "%#{params[:query]}%")
    else
      @questions = Question.all
    end
  end

  def new
    @question = Question.new
  end

  def new_admin
    @question = Question.new
  end

  def create
    @question = Question.find_by("query ILIKE ?", "%#{params[:question][:query]}%")
    if @question
      redirect_to @question.link.url
    else
      @question = Question.new(question_params)
      @question.save
      redirect_to questions_path
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(params[:question])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
  end


  private
  def question_params
    params.require(:question).permit(:query, :link_id)
  end
end
