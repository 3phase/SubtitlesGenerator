# executing the modules for SubtitleGenerator

require_relative './convert.rb'
require_relative './audio2text.rb'
require_relative './text2srt.rb'

def let_the_magic_begin(input_file, language)
	run_convert(input_file)
	file = return_file_name(get_file_name(input_file))
	text = run_audio2text(file, language)
	remove_audio_file(get_file_name(input_file))
	run_text2srt(text, get_file_name(input_file))
	srt_file = get_file_name(input_file) + ".srt"
end
