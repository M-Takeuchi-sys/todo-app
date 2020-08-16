class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @comments = @task.comments
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params.merge!(user_id: current_user.id))
    if @task.save
      redirect_to board_path(board), notice: 'タスクを追加'
    else
      flash.now[:error] = 'タスクを追加できませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to board_task_path(board_id: @task.board_id, id: @task.id), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(board), notice: '削除に成功しました'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :eyecatch)
  end

  def set_task
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
  end
end
