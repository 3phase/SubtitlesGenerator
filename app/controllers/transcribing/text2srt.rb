# making the output text of the transcription in srt format
require 'time'

def die(message)
	puts message
	exit
end

def snippets(string)
	i = 0
	n = 4
	if string.empty?
		die("Error transcribing file!\n")
	end
	string = string.gsub!(/\s+/) { |s| (i = (i+1) % n).zero? ? "\n" : s }
	string = string.split("\n")
	arr = []
	string.each_slice(2) do |s|
		arr << s
	end
	arr
end

def get_times(array)
	start_time = 0
	end_time = 3
	counter = 0
	time_array = []
	array.each do |part|
		time_array[counter] = add_time(start_time, end_time)
		start_time += 3
		end_time += 3
		counter += 1
	end
	time_array
end

def file_exist?(file)
	if File.exist?(file) == true
		File.delete(file)
	end
end

def add_paragraph(p)
	"#{p}\n"
end

def process_array(text_array)
	text_array.join("\n")
end

def convert_time(seconds)
	Time.at(seconds).utc.strftime("%H:%M:%S")
end

def add_time(start_time, end_time)
	"#{convert_time(start_time).to_s}:000 --> #{convert_time(end_time).to_s}:000\n"
end

def write_to_file(filename, paragraph_counter, s, time)
	open(Rails.public_path.join("transcribed_data/#{filename}.srt"), "a") do |f|
		f << add_paragraph(paragraph_counter)
		f << time
		f << process_array(s)
		f << "\n\n"
	end
end

def text2srt(text_array,filename)
	paragraph_counter = 0
	time_array = get_times(text_array)
	file_exist?("../../../public/transcribed_data/#{filename}.srt")
	text_array.each do |sentence|
		paragraph_counter += 1 
		write_to_file(filename, paragraph_counter, sentence, time_array[paragraph_counter-1])
	end
end

def run_text2srt(content, filename)
	sentences = snippets(content)
	text2srt(sentences, filename)
end
