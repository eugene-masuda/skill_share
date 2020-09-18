class PagesController < ApplicationController
  def home
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com', full_name: 'ゲストユーザー') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def search
    @categories = Category.all
    @category = Category.find(params[:category]) if params[:category].present?

    @q = params[:q]
    @min = params[:min]
    @max = params[:max]
    @delivery = params[:delivery].present? ? params[:delivery] : "0"
    @sort = params[:sort].present? ? params[:sort] : "price asc"

    query_condition = []
    query_condition[0] = "gigs.active = true"
    query_condition[0] += " AND ((gigs.has_single_pricing = true AND pricings.pricing_type = 0) OR (gigs.has_single_pricing = false))"

    if !@q.blank?
      query_condition[0] += " AND gigs.title ILIKE ?"
      query_condition.push "%#{@q}%"
    end

    if !params[:category].blank?
      query_condition[0] += " AND category_id = ?"
      query_condition.push params[:category]
    end

    if !params[:min].blank?
      query_condition[0] += " AND pricings.price >= ?"
      query_condition.push @min
    end

    if !params[:max].blank?
      query_condition[0] += " AND pricings.price <= ?"
      query_condition.push @max
    end

    if !params[:delivery].blank? && params[:delivery] != "0"
      query_condition[0] += " AND pricings.delivery_time <= ?"
      query_condition.push @delivery
    end

    @gigs = Gig
      .select("gigs.id, gigs.title, gigs.user_id, MIN(pricings.price) AS price")
      .joins(:pricings)
      .where(query_condition)
      .group("gigs.id")
      .order(@sort)
      .page(params[:page])
      .per(6)
  end

  def calendar
    params[:start_date] ||= Date.current.to_s

    start_date = Date.parse(params[:start_date])
    first_of_month = (start_date - 1.month).beginning_of_month
    end_of_month = (start_date + 1.month).end_of_month

    @orders = Order.where("seller_id = ? AND status = ? AND due_date BETWEEN ? AND ?",
                          current_user.id,
                          Order.statuses[:inprogress],
                          first_of_month,
                          end_of_month)
  end

  def plans
    @plans = Stripe::Plan.list(product: 'prod_HwklVCNEmNIEDW')
  end
end
