class BasketItemsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:create, :destroy]
  def create
    @basket = current_basket
    @basket_item = @basket.basket_items.build(params[:basket_items])

    if @basket_item.save
      flash[:notice] = "Product added to your shopping basket"
      redirect_to basket_path(@basket)
    else
      flash[:notice] = "Product could not be added to your shopping basket"
    end
  end

  def destroy
    @basket_item = BasketItem.find(params[:id])
    @basket_item.destroy
    if @basket_item.destroy
      flash[:notice] = "Product has been removed from your shopping basket"
      redirect_to current_basket
    else
      flash[:notice] = "Product couldn't be removed from the shopping basket"
      redirect_to basket_path
    end
  end

  def update
    @basket_item = BasketItem.find(params[:basket_item])
    if @basket_item.update_attributes(params[:basket_item])
      flash.now[:notice] = "Basket Updated"
    else
      flash.now[:error] = "Basket could not be updated"
      render "edit"
    end
  end
end