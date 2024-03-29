class SubscriptionsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_subscription, only: [:destroy]
  after_action :verify_authorized, only: [:destroy]

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    authorize @new_subscription
    @new_subscription.user = current_user

    if @new_subscription.save
      NotifySubscribersJob.perform_later(@new_subscription)
      redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
    else
      render 'events/show', alert: I18n.t('controllers.subscriptions.error')
    end
  end

  def destroy
    authorize @subscription
    message = { notice: I18n.t('controllers.subscriptions.destroyed') }

    @subscription.destroy

    redirect_to @event, message
  end

  private

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
