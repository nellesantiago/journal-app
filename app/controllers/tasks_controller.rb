class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: %i[ show edit update destroy ]
  
    def index
        @category = current_user.categories.find(params[:category_id])
        @tasks = @category.tasks
    end
  
    def show
    end
  
    def new
      @category = current_user.categories.find(params[:category_id])
      @task = @category.tasks.build
    end
  
    def edit
        @category = current_user.categories.find(params[:category_id])
        @task = @category.tasks.find(params[:id])
    end
  
    def create
      @category = current_user.categories.find(params[:category_id])
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
          format.html { redirect_to category_tasks_path, notice: "Task was successfully updated." }
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
        format.html { redirect_to category_tasks_path, notice: "Task was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      def set_task
        @task = Task.find(params[:id])
      end
  
      def task_params
        params.require(:task).permit(:title, :body, :date, :category_id)
      end
  end
  