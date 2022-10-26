class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    # @post_image.user_id = current_user(現在のユーザーログイン中のユーザーの.idを取得)
    @post_image.user_id = current_user.id
    @post_image.save
    redirect_to post_images_path
  end

  def index
    # ページネーション仕様に書き換えpage(params[:id])はkaminariをインストールしたことで使用可能に
    @post_images = PostImage.page(params[:page])
    # @post_images = PostImage.all
  end

  def show
    @post_image = PostImage.find(params[:id])
    # コメント投稿のための新しいインスタンスの作成
    @post_comment = PostComment.new
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end
end
