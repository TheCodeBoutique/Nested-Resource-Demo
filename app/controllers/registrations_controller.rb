class RegistrationsController < ApplicationController

  before_filter :find_event

  def index
    @registrations = @event.registrations.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @registrations }
    end
  end
  
  # other CRUD actions
  

  
  def show
    @registration = @event.registrations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @registration }
    end
  end
  
  def edit
    @registration = @event.registrations.find(params[:id])
  end
  
  def destroy
    @registration = @event.registrations.find(params[:id])
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to(event_registrations_url(@event)) }
      format.json  { head :ok }
    end
  end
  

  
  def new
    @registration = @event.registrations.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @registration }
    end
  end
  

  
  def create
    @registration = @event.registrations.new(params[:registration])

    respond_to do |format|
      if @registration.save
        flash[:notice] = 'Registration was successfully created.'
        format.html { redirect_to([@event, @registration]) }
        format.json  { render :json => @registration, 
                             :status => :created, 
                             :location => [ @event, @registration ] }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @registration.errors, 
                             :status => :unprocessable_entity }
      end
    end
  end
  

  
  def update
    @registration = @event.registrations.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        flash[:notice] = 'Registration was successfully updated.'
        format.html { redirect_to([@event, @registration]) }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @registration.errors, 
                             :status => :unprocessable_entity }
      end
    end
    

  end
  


private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
