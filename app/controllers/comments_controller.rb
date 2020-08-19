class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    @comment = task.comments.build
  end

def create
  task = Task.find(params[:task_id])
  @comment = task.comments.build(comment_params.merge!(user_id: current_user.id))
  if  @comment.save
    redirect_to board_task_path(board_id: task.board_id, id: task.id), notice: 'コメントを追加'
  else
    flash.now[:error] = '更新できませんでした'
    render :new
  end
end

  private
  def comment_params
    params.require(:comment).permit(:user, :content)
  end
end
