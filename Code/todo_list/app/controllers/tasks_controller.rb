class TasksController < ApplicationController

  def index
    @tasks = @current_user.tasks.all
    @task = @current_user.tasks.new
  end

  def create
    @task = @current_user.tasks.new(task_params)
    @task.completed = false
    if @task.save
      flash[:success] = "Task Created Sucessfully! "
      redirect_to root_path
    else
      flash[:error] = "Unable to create task: Description empty! "
      redirect_to task_path
    end
  end

  def toggle
    @task = @current_user.tasks.find(params[:id])
    @task.update_attributes(:completed => params[:completed])
  end

  def edit
    @task=@current_user.tasks.find(params[:id])
  end

  def update
    @task=@current_user.tasks.find(params[:id])
    @task.update(description: params[:task][:description])

    new_category_name=params[:task][:categories][:name]

    # if category specified
    if (new_category_name) != ""
      # if task has no existing category
      if @task.categories[0].nil?
          @category=Category.find_by(name: new_category_name)
          # if category does not exist
          if @category.nil?
            @category=Category.new(name: new_category_name)
            @category.save
            @task.categories<< @category
          else
            @task.categories<< @category
          end
      else
        # existing category name is different
        if @task.categories.find_by(name: new_category_name).nil?
          @category=Category.find_by(name: new_category_name)
          # if category does not exist
          if @category.nil?
            @category=Category.new(name: new_category_name)
            @category.save
        end
        @task.categories.clear
        @task.categories<< @category
      end
    end

    # Code to support multiple categories
    #if (new_category_name) != ""
    #  @category=Category.find_by(name: new_category_name)
    #  if @category.nil?
    #    @category=Category.new(name: new_category_name)
    #    @category.save
    #    @task.categories<< @category
    #  elsif @task.categories.find_by(name: new_category_name).nil?
    #    @task.categories<< @category
    #  end
      @task.save
    end
    render 'index'
  end

  def destroy
    @task=@current_user.tasks.find(params[:id])
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end
