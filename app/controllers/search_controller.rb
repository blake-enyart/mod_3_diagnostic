class SearchController < ApplicationController
  def index
    render locals: {
                     facade: SearchResultsFacade.new(params[:q])
                   }
  end
end
