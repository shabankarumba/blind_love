require 'spec_helper'

describe BasketItem do
  let(:product) { FactoryGirl.create(:product) }
  let!(:sizing) { FactoryGirl.create(:sizing, :product_id => product.id )}
  let(:basket) { FactoryGirl.create(:basket)}
  let(:basket_item) { FactoryGirl.create(:basket_item, :product_id => product.id, :sizing_id => sizing.id ) }

  it { should belong_to(:basket) }
  it { should belong_to(:product) }
  it { should belong_to(:order)}
  it { should validate_presence_of(:product_id) }
  it { should validate_presence_of(:sizing_id) }
  it { should validate_presence_of(:basket_id) }

  it "returns the quantity left for the sizing" do
    product = FactoryGirl.create(:product)
    sizing = FactoryGirl.create(:sizing, :product_id => product.id )
    basket_item = FactoryGirl.create(:basket_item, :product_id => product.id, :sizing_id => sizing.id )
    b = BasketItem.size_quantity(sizing.id, product.id)
    b.map {|b| b.quantity}.should == [10]
  end

  it "should sum the totals for products in the shopping basket" do
    basket_item = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id )
    BasketItem.product_totals(basket.id).should == 9999
  end

  it "merge duplicate products" do
    basket_item = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id, :sizing_id => 1)
    basket_item_two = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id, :sizing_id => 1)

    BasketItem.add_item(basket_item)
    b = BasketItem.add_item(basket_item_two)
    b.quantity.should == 2
  end

  it "not merge non-duplicate products" do
    basket_item_two = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id, :sizing_id => 3)

    [basket_item, basket_item_two].each do |b|
      BasketItem.add_item(b)
    end

    BasketItem.where(:basket_id => basket.id).map {|b| b.quantity }
    .should == [1] 
  end

  it "sums the product price by the quantity" do
    basket_item = FactoryGirl.create(:basket_item, :quantity => 2)
    basket_item.price_times_quantity 
    basket_item.item_price.should == 19998
  end

  it "gives an error when there no more products" do
    sizing = FactoryGirl.create(:sizing, :quantity => 0, :product_id => product.id)
    basket_item = FactoryGirl.create(:basket_item, :quantity => 2, :sizing_id => sizing.id)
    b = BasketItem.update_item(basket_item)
    b.should == ["Oh no there's no more in stock"]
  end

  it "adds the desired quantity" do
    sizing = FactoryGirl.create(:sizing, :quantity => 2, :product_id => product.id)
    basket_item = FactoryGirl.create(:basket_item, :quantity => 2, :sizing_id => sizing.id)
    BasketItem.update_item(basket_item)
    BasketItem.all.map {|b| b.quantity }.should == [2]
  end

  it "adds the quantity left over" do
    sizing = FactoryGirl.create(:sizing, :quantity => 1, :product_id => product.id)
    basket_item = FactoryGirl.create(:basket_item, :quantity => 2, :sizing_id => sizing.id)
    BasketItem.update_item(basket_item)
    BasketItem.all.map {|b| b.quantity}.should == [1]
  end

  it "deducts from the stock" do
    sizing = create(:sizing, :quantity => 1, :product_id => product.id)
    basket_item = create(:basket_item, :quantity => 1, :sizing_id => sizing.id)
    basket_item.reduce_stock_avaliable
    basket_item.sizing.quantity.should == 0
  end
end
