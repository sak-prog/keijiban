class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :correct_user, only: [:edit, :destroy]

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
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:success] = "スレッドを作成しました！"
      redirect_to board_path(@board)
    else
      flash[:alert] = "スレッドの作成に失敗しました"
      redirect_to boards_path
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    @board.update(board_params)
    flash[:notice] = "タイトルを更新しました"
    redirect_to boards_path
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    flash[:notice] = "スレッドを削除しました"
    redirect_to boards_path
  end

  private

  def board_params
    params.permit(:title)
  end

  def correct_user
    @board = current_user.boards.find_by(id: params[:id])
    redirect_to boards_path if @board.nil?
  end
end
