class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, except: %i[update destroy]
    before_action :set_task, only: %i[edit update destroy show]
    before_action :sort_task, only: %i[index show]
  
    def index
        @tasks = @category.tasks  
    end
  
    def show
    end
  
    def new
      @task = @category.tasks.build
    end
  
    def edit
    end
  
    def create
      @task = @category.tasks.create(task_params)
  
        if @task.save
          redirect_to category_tasks_path(@category), notice: "Task was successfully created."
        else
         render :new
      end
    end
  
    def update
        if @task.update(task_params)
          redirect_to category_tasks_path, notice: "Successfully updated task!"
        else
         render :edit
      end
    end
  
    def destroy
      @task.destroy
  
       redirect_to category_tasks_path, notice: "Task was successfully deleted."
    end
  
    private
      def set_category
        @category = current_user.categories.find(params[:category_id])
      end

      def set_task
        @category = current_user.categories.find(params[:category_id])
        @task = @category.tasks.find(params[:id])
      end
  
      def task_params
        params.require(:task).permit(:title, :body, :date, :category_id, :checked)
      end

      def sort_task
        @today = @category.tasks.where('date = ?', Date.current)
        @scheduled = @category.tasks.where('date > ?', Date.current)
        @overdue = @category.tasks.where('date < ?', Date.current)
      end
  end
  