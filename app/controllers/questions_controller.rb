class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create, :index, :answer]

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
    @link = Link.new
  end

  def create
    @question = Question.find_by("query ILIKE ?", "%#{params[:question][:query]}%")
    if @question
      redirect_to @question.link.url
    else
      @question = Question.new(question_params)
      if params[:link] == nil
        @question.link_id = 'link0_id'
      end
      if current_user != nil
        @link = params[:question][:link][:url]
      end
      if Link.find_by(url: @link)
        @question.link = Link.find_by(url: @link)
      else
        @newlink = Link.create!(url: @link)
        @question.link = @newlink
      end
      @question.save!
        if current_user != nil
          redirect_to questions_path
        else
          redirect_to questions_answer_path
        end
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

  def answer
    @questions = Question.all
  end

  private
  def question_params
    params.require(:question).permit(:query, :link_id, tag_list: [])
  end
end
