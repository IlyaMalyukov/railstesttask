class AdsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @ad = current_user.ads.build(ad_params)
    if @ad.save
      flash[:success] = "Объявление опубликовано!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  def ad_params
    params.require(:ad).permit(:content)
  end
end
