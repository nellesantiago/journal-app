class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, except: %i[update destroy]
    before_action :set_task, only: %i[ edit update destroy ]
  
    def index
        @tasks = @category.tasks
        @today = @category.tasks.where('date = ?', Date.current)
        @scheduled = @category.tasks.where('date > ?', Date.current)
        @overdue = @category.tasks.where('date < ?', Date.current)
    end
  
    def show
        @task = @category.tasks.find(params[:id])
        @today = @category.tasks.where('date = ?', Date.current)
        @scheduled = @category.tasks.where('date > ?', Date.current)
        @overdue = @category.tasks.where('date < ?', Date.current)
    end
  
    def new
      @task = @category.tasks.build
    end
  
    def edit
        @task = @category.tasks.find(params[:id])
    end
  
    def create
      @task = @category.tasks.create(task_params)
  
      respond_to do |format|
        if @task.save
          format.html { redirect_to category_tasks_path(@category), notice: "Task was successfully created." }
          format.json { render :show, status: :created, location: @task }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to category_tasks_path, notice: "Succesfully updated task!" }
          format.json { render :show, status: :ok, location: @task }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @task.destroy
  
      respond_to do |format|
        format.html { redirect_to category_tasks_path, notice: "Task was successfully deleted." }
        format.json { head :no_content }
      end
    end
  
    private
      def set_category
        @category = current_user.categories.find(params[:category_id])
      end

      def set_task
        @task = Task.find(params[:id])
      end
  
      def task_params
        params.require(:task).permit(:title, :body, :date, :category_id, :checked)
      end
  end
  