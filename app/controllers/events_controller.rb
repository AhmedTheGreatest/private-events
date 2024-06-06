class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authorize_creator, only: [:edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    redirect_to events_url, notice: 'Event was successfully deleted.'
  end

  private

  def authorize_creator
    return if Event.find(params[:id]).creator == current_user

    redirect_to events_url, alert: 'You are not allowed to do that!'
  end

  def event_params
    params.require(:event).permit(:name, :date, :location, :creator_id)
  end
end
