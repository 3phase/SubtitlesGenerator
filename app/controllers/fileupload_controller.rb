require_relative './transcribing/execute.rb'
require_relative './transcribing/parse_yaml.rb'

class FileuploadController < ApplicationController
  before_action :authenticate_user!
  def new
  	@filehandler = FileHandler.new
  end

  def index
    render :file => 'app/views/fileupload/uploadfile.html.erb'
  end

  def plans
  end

  def create
    name = params[:upload][:file].original_filename
    directory = "public/data"
    path = File.join(directory, name)
    if not File.exists? directory
      `mkdir "#{directory}"`
    end
    File.open(path, "wb") { |f| f.write(params[:upload][:file].read) }
    lang = transform_lang(params[:upload][:lang])
    srt_file = let_the_magic_begin(path, lang.to_s)
    system("rm #{path}")
    redirect_to :controller => :download, :action => 'srt', :filename_param => srt_file.to_s
  end
end
