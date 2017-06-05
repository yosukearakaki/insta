class PicturesController < ApplicationController
  before_action :set_picture, :authenticate_user!, only: [:edit, :update, :destroy]
  
  def index
    @pictures = Picture.all
  end

  def new
    if params[:back]
      @picture = Picture.new(pictures_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = Picture.new(pictures_params)
    @picture.user_id = current_user.id
    if @picture.save
      redirect_to pictures_path, notice: "画像を投稿しました！"
    else
      render 'new'
    end
  end
  
  # def confirm
  # @picture = Picture.new(pictures_params)
  #  render :new if @picture.invalid?
  # end
  
  def edit
    @picture = Picture.find(params[:id])
  end
  
  def update
    @picture = Picture.find(params[:id])
    @picture.update(pictures_params)
    redirect_to pictures_path, notice: "投稿を更新しました！"
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path, notice: "投稿を削除しました！"
  end
  
  private
    def pictures_params
      params.require(:picture).permit(:image, :content)
    end

    def set_picture
      @picture = Picture.find(params[:id])
    end
end
