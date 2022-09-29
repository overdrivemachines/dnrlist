class StaticPagesController < ApplicationController
  def message
    # if there is no message redirect to root
    if !flash[:notice]
      redirect_to root_url
    end
  end
end
