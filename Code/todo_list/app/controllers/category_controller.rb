class CategoryController < ApplicationController

  def show
    @tasks = @current_user.tasks.includes(:categories).where("categories.name" => params[:name])
  end

  def new
  end

  def update
  end

  def destroy
  end
end
