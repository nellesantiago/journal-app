class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: :page
  before_action :set_category, only: %i[ show edit update destroy]

  # GET /categories
  def index
    @categories = current_user.categories
    @tasks = current_user.tasks
    @today = @tasks.where('date = ?', Date.current)
  end

  # GET /categories/id/tasks
  def show
    @tasks = @category.tasks
  end

  # GET /categories/new
  def new
    @category = current_user.categories.build
  end

  # GET /categories/id/edit
  def edit
  end

  # POST /categories
  def create
    @category = current_user.categories.build(category_params)

      if @category.save
        redirect_to categories_path, notice: "Category was successfully created."
      else
       render :new
    end
  end

  # PATCH/PUT /categories/id
  def update
      if @category.update(category_params)
       redirect_to categories_path, notice: "Category was successfully updated."
      else
        render :edit
    end
  end

  # DELETE /categories/id
  def destroy
    @category.destroy

    redirect_to categories_url, notice: "Category was successfully deleted." 
  end

  private
 
    def set_category
      @category = current_user.categories.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title, :user_id)
    end
end