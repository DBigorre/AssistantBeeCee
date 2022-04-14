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

  def to_ascii
    Question.query = ActiveSupport::Inflector.transliterate(query).to_s
  end

  def create
      queryp = params[:question][:query]
      queryp = queryp.parameterize(separator: ' ')
      queryp = queryp.chomp("?")
      @question = Question.find_by("query ILIKE ?", "%#{params[:question][:query]}%")
      if @question.present?
        if @question.link.url.include?("http") 
          redirect_to @question.link.url and return
        elsif @question.present? 
          redirect_to questions_answer_path and return
        end
      elsif Question.all.include?(queryp)
        Question.all.each do |question|
          if question.query.parameterize(separator: ' ') == queryp
            raise
            @question = question 
            redirect_to @question.link.url and return
          end
        end
      else
        @question = Question.new(question_params)
        if params[:link] == nil 
          @newlink = Link.create!(url: "   ")
          @question.link = @newlink
          @question.save!
          redirect_to questions_answer_path and return
        end
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
