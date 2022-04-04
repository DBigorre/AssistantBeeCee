class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create, :index, :answer]

  def index
    if params[:search].present?
      query = " \
        questions.query ILIKE :search \
        OR links.url ILIKE :search \
        "
      @questions = Question.joins(:link).where(query, search: "%#{params[:search]}%")
    else
      @questions = Question.all
    end
  end

  def new
    @question = Question.new
  end

  def ask
    @question = Question.find_by("query ILIKE ?", "%#{params[:question][:query]}%")
    if @question
      redirect_to @question.link.url
    else
      @question = Question.new(question_params)
      if params[:link] == nil
        @question.link_id = 'link0_id'
      end
      @question.save!
      redirect_to questions_answer_path
    end
  end

  def new_admin
    @question = Question.new
    @link = Link.new
  end

def create
  @question = Question.find_by("query ILIKE ?", "%#{params[:question][:query]}%")
  if @question
    flash.alert = "La question existe déjà en base !"
    redirect_to questions_new_admin_path
  else
    @question = Question.new(question_params)
    @link = params[:question][:link][:url]
    @newlink = Link.create!(url: @link)
    @question.link = @newlink
    @question.save!
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

  def answer
    @questions = Question.all
  end

  private
  def question_params
    params.require(:question).permit(:query, :link_id, tag_list: [])
  end
end
