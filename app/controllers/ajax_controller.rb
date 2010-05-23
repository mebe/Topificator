class AjaxController < ApplicationController
  def get_channels
    @channels = Channel.find(:all)
    @headers['content-type'] = 'text/javascript'
  end
end
