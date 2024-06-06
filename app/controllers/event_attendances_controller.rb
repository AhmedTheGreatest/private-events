class EventAttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_event, only: [:new, :create]
  before_action :already_enrolled, only: [:new, :create]

  def new
    @event_attendance = EventAttendance.new
  end

  def create
    @event_attendance = EventAttendance.new(event_id: @event.id, attendee: current_user)

    if @event_attendance.save
      redirect_to @event, notice: "Successfully enrolled in #{@event.name}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find_by(id: params[:event_id])
    redirect_to events_path, alert: "Event not found." unless @event
  end

  def already_enrolled
    redirect_to @event, notice: "You are already enrolled in #{@event.name}" if @event.attendees.include?(current_user)
  end
end
