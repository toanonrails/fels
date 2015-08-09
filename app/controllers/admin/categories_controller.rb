class Admin::CategoriesController < Admin::BackendController
  before_action :load_category, only: [:edit, :show, :update, :destroy]

  def index
    @categories = Category.all.order created_at: :desc
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "New category is successfully created."
      redirect_to admin_categories_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = "Category is successfully updated."
      redirect_to request.url
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Category is successfully deleted."
    redirect_to admin_categories_path
  end

  private
  def load_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name, :description
  end
end
