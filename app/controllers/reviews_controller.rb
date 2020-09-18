class ReviewsController < ApplicationController
  def create
    order = Order.find(review_params[:order_id])
    if order && current_user.id == order.buyer.id
      if Review.exists?(order_id: review_params[:order_id], buyer_id: current_user.id)
        flash[:alert] = "すでにレビューを作成しています"
      else
        review = Review.new(review_params)
        review.gig = order.gig
        review.buyer = current_user
        review.seller = order.seller
        if review.save
          flash[:notice] = "保存しました"
        else
          flash[:alert] = "レビューを作成できませんでした"
        end
      end
    else
      flash[:alert] = "オーダーが無効です"
    end
    redirect_to request.referrer
  end

  private

  def review_params
    params.require(:review).permit(:stars, :review, :order_id)
  end
end
