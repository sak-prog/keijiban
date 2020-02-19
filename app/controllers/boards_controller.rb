class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :correct_user, only: [:edit, :destroy]

  def index
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = Board.ransack(search_params)
    else
      @q = Board.ransack
    end
    @boards = @q.result(distinct: true)
    if params[:tag_name]
      @boards = @boards.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
    @board = Board.find(params[:id])
    @comments = @board.comments
    @comment = Comment.new
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
    params.require(:board).permit(:title, :tag_list)
  end

  def correct_user
    @board = current_user.boards.find_by(id: params[:id])
    redirect_to boards_path if @board.nil?
  end

  def search_params
    params.require(:q).permit(:title_or_tags_name_cont)
  end
end
