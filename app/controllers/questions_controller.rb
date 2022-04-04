class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create, :index, :answer, :ask]

  def index
    if params[:search].present?
      query = " \
        questions.query ILIKE :search \
        OR links.url ILIKE :search \
        "
      @questions = Question.joins(:link).where(query, search: "%#{params[:search]}%").order('created_at DESC')
    else
      @questions = Question.all.order('created_at DESC')
    end
  end

  def new
    @question = Question.new
  end

  def ask
    @question = Question.find_by("query ILIKE ?", "%#{params[:question][:query]}%")
    if @question.present?
      redirect_to @question.link.url
    else
      @question = Question.new(question_params)
      if params[:link] == nil
        @newlink = Link.create!(url: questions_answer_path)
        @question.link = @newlink
      end
      @question.save!
      redirect_to questions_answer_path
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
    @question.update(question_link_params)
    redirect_to questions_path
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
  end

  def answer
  end

  private

  def question_params
    params.require(:question).permit(:query, :link_id, tag_list: [])
  end

  def question_link_params
    params.require(:question).permit(:query, question: [:link][:url])
  end

end
