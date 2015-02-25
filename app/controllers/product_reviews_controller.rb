class ProductReviewsController < ApplicationController

  def index
    @products = Product.find(parmas[:product_id])
    @product_reviews = ProductReviews.all
  end

  def new
    @product = Product.find(params[:product_id])
    @product_review = ProductReview.new
  end

  def create
    @product = Product.find(params[:product_id])
    if current_user
      @product_review = ProductReview.new(product_review_params)
      @product_review.product_id = @product.id
      @product_review.user_id = current_user.id
      @product_review.save
      redirect_to products_path
    else
      redirect_to login_path, notice: "Must login to review products."
    end
  end


  private
  def product_review_params
    params.require(:product_review).permit(:title, :description, :rating)
  end


end
