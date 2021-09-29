class NotFoundController < ApplicationController
  def default
    render_error('Not Found', 404)
  end
end
