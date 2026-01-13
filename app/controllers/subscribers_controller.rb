class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "signup_form",
            partial: "subscribers/success"
          )
        end
        format.html { redirect_to root_path, notice: "Thanks for signing up!" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "signup_form",
            partial: "subscribers/form",
            locals: { subscriber: @subscriber }
          )
        end
        format.html { render "pages/home", status: :unprocessable_entity }
      end
    end
  end

  private

  def subscriber_params
    params.expect(subscriber: [:email])
  end
end
