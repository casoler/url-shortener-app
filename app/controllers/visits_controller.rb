class VisitsController < ApplicationController
  def create
    link = Link.find_by(id: params[:link_id])
    
    if link 
      @visit = Visit.new(
        link_id: link.id,
        ip_address: request.remote_ip)

      if @visit.save
        redirect_to "http://#{link.target_url}"
      else
        flash[:notice] = 'Oops!  Visit not saved.  Try again.'
        redirect_to '/links'
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
