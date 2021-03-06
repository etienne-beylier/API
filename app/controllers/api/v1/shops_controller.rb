class Api::V1::ShopsController < Api::V1::BaseController

  before_action :authenticate_user!, only: [:create, :update, :destroy]

  before_action :set_shop, only: [:update, :show, :destroy]
  before_action :set_event, only: [:create]

  include DestroyResourceWithStatus

  def index
    @shops = Shop.where(event_id: params[:event_id])

    render json: @shops.as_json
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.event_id = @event.id

    if @shop.save
      render_resource_successed(@shop)
    else
      render_resource_failed(@shop)
    end
  end

  def update
    authorize! :update, @shop
    if @shop.update_attributes(shop_params)
      render_resource_successed(@shop)
    else
      render_resource_failed(@shop)
    end
  end

  def destroy
    authorize! :destroy, @shop
    destroy_resource(@shop)
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def set_event
    @event = Event.find_by_id(params[:event_id])

    if @event.nil?
      render_nested_resource_doesnt_exists("Event #{params[:event_id]}")
    end
  end

  def shop_params
    params.require(:shop).permit(
      :name,
      :description,
      :owner_id
    )
  end
end
