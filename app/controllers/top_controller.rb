class TopController < ApplicationController
  def show
    request.headers.sort.map { |k, v| logger.info "#{k}:#{v}" }
  end
end
