# requires ffmpeg 
# requires installation "sudo apt-get install ffmpeg libavcodec-extra-52"
# converting video to 1 channel 16 bits wav file 

def get_file_name(file)
	name = file.split("/").last.split(".").first.to_s
end

def die(message)
	puts message
	exit
end

def convert_file(file, filename)
	puts "Converting file...\n"
	if not File.exists? "public/transcribed_data/"
      `mkdir public/transcribed_data/`
    end
	system("ffmpeg -y -i #{file} -vn -acodec pcm_s16le -ar 44100 -ac 1 public/transcribed_data/#{filename}.wav 2> /dev/null")
	if $?.success? 
		puts "Convertion successful!\n" 
	else 
		puts "Convertion failed!\n"
		die("Something went wrong...") 
	end
end

def return_file_name(filename)
	"public/transcribed_data/#{filename}.wav"
end

def remove_audio_file(filename)
	`rm public/transcribed_data/#{filename}.wav`
end

def run_convert(file)
	convert_file(file, get_file_name(file))
end