class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list.html.erb" })
  end

  def show
    venue_id = params.fetch("venue_id")
    matching_venue = Venue.where({ :id => venue_id }).at(0)
    @the_venue = matching_venue

    render({ :template => "venue_templates/details.html.erb" })
  end

  def create
    @venue = Venue.new
    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")
    @venue.neighborhood = params.fetch("query_neighborhood")
    @venue.save

    redirect_to("/venues/#{@venue.id}")
  end
  
  def update
    the_id = params.fetch("venue_id")

    @venue = Venue.where({ :id => the_id }).at(0)
    new_address = params.fetch("query_address")
    new_name = params.fetch("query_name")
    new_neighborhood = params.fetch("query_neighborhood")

    @venue.address = new_address
    @venue.name = new_name
    @venue.neighborhood = new_neighborhood
    @venue.save
    
    redirect_to("/venues/#{@venue.id}")
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    venue = Venue.where({ :id => the_id }).at(0)
   
    venue.destroy

    redirect_to("/venues")
  end

end
