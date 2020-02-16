class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:success] = "スレッドを作成しました！"
      redirect_to board_url(@board)
    else
      flash[:alert] = "スレッドの作成に失敗しました"
      redirect_to boards_path
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    flash[:notice] = "スレッドを削除しました"
    redirect_to board_path
  end

  private

  def board_params
    params.permit(:title)
  end
end
