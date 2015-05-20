class DownloadController < ApplicationController
  def index
  end

  def srt
  	filepath = Rails.public_path.join('transcribed_data/', params[:filename_param])
  	send_file filepath, :type=>"application/srt", :x_sendfile=>true
  end
end
