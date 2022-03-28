class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!

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

  def create
    @question = Question.new(params[:question])
    @question.save
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
    params.require(:question).permit(:url)
  end
end
