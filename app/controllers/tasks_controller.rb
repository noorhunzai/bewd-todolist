class TasksController < ApplicationController
  def index
    @tasks = Task.all
    render 'tasks/index' # can be omitted
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render 'tasks/create' # can be omitted
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task&.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def mark_complete
    @task = Task.find_by(id: params[:id])

    render 'tasks/update' if @task&.update(completed: true)
  end

  def mark_active
    @task = Task.find_by(id: params[:id])

    render 'tasks/update' if @task&.update(completed: false)
  end

  private

  def task_params
    params.require(:task).permit(:content)
  end
end
