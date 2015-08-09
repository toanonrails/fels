class Admin::WordsController < Admin::BackendController
  before_action :load_word, except: [:index, :new, :create]

  def index
    @words = Word.all
  end

  def show
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = "A new word is successfully created."
      redirect_to [:admin, @word]
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      redirect_to [:admin, @word]
    else
      render "edit"
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = "Word is successfully deleted."
      redirect_to admin_words_url
    end
  end

  private
  def load_word
    @word = Word.find params[:id]
  end

  def word_params
    params.require(:word).permit :content, options_attributes: [:id, :content, :correct, :_destroy]
  end
end
