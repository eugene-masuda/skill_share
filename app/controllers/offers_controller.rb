class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_offer, only: [:accept, :reject]
  before_action :is_authorised, only: [:accept, :reject]

  def create
    req = Request.find(offer_params[:request_id])

    if req && req.user_id == current_user.id
      redirect_to request.referrer, alert: "自分のリクエストにオファーはできません"
    end

    if Offer.exists?(user_id: current_user.id, request_id: offer_params[:request_id])
      redirect_to request.referrer, alert: "現時点で提供できるオファーは1つだけです"
    end

    @offer = current_user.offers.build(offer_params)
    if @offer.save
      redirect_to my_offers_path, notice: "保存しました"
    else
      redirect_to request.referrer, flash: {error: @offer.errors.full_messages.join(', ')}
    end
  end

  def accept
    if @offer.pending?
      @offer.accepted!

      if charge(@offer.request, @offer)
        flash[:notice] = "認証されました"
        return redirect_to buying_orders_path
      else
        flash[:alert] = "オーダーの作成に失敗しました"
      end
    end
    redirect_to request.referrer
  end

  def reject
    if @offer.pending?
      @offer.rejected!
      flash[:notice] = "拒否されました"
    end
    redirect_to request.referrer
  end

  private

  def charge(req, offer)
    order = req.orders.new
    order.due_date = Date.today() + offer.days
    order.title = req.title
    order.seller_name = offer.user.full_name
    order.seller_id = offer.user.id
    order.buyer_name = current_user.full_name
    order.buyer_id = current_user.id
    order.amount = offer.amount
    order.save
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def is_authorised
    redirect_to root_path, alert: "You don't have permission" unless current_user.id == @offer.request.user_id
  end

  def offer_params
    params.require(:offer).permit(:amount, :days, :note, :request_id, :status)
  end
end
