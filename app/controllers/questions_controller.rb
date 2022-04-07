class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create, :index, :answer, :ask]

  def index
    if params[:search].present?
      query = " \
        questions.query ILIKE :search \
        OR links.url ILIKE :search \
        "
      @questions = Question.joins(:link).where(query, search: "%#{params[:search]}%").order('created_at DESC')
    elsif params[:search_tag]
      @filter = params[:search_tag][:tags]
      @questions = @filter.empty? ? Question.all : Question.all.tagged_with(@filter, any: true)
    else
      @questions = Question.all.order('created_at DESC')
    end
  end

  def new
    @question = Question.new
  end

  def ask
    @question = Question.find_by("query ILIKE ?", "%#{params[:question][:query]}%")
    if @question
      flash.alert = "La question existe déjà en base !"
      redirect_to questions_new_admin_path
    else
      @question = Question.new(question_params)
      @link = params[:question][:link][:url]
      @newlink = Link.create!(url: @link)
      @question.link = @newlink
      tag_list = params[:question][:tag_list]
      @question.tag_list = tag_list
      @question.save!
      redirect_to questions_path
    end
  end

  def new_admin
    @question = Question.new
    @link = Link.new
  end

def create
  @question = Question.find_by("query ILIKE ?", "%#{params[:question][:query]}%")
  if @question.present?
    redirect_to @question.link.url
  else
    @question = Question.new(question_params)
    if params[:link] == nil
      @newlink = Link.create!(url: "   ")
      @question.link = @newlink
    end
    @question.save!
    redirect_to questions_answer_path
  end
end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    @link = params[:question][:link][:url]
    @newlink = Link.create!(url: @link)
    @question.link = @newlink
    @tag_list = params[:question][:tag_list]
    @question.tag_list = @tag_list
    @question.save!
    redirect_to questions_path
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  def answer
    @question = Question.last
    @questions = Question.all
  end

  private

  def question_params
    params.require(:question).permit(:query, :link_id, :tag_list)
  end

  def question_link_params
   #params.require(:question).permit(:query, question: [:link][:url])
   params.permit(:query, :link, :url)
  end
end
