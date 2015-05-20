# transcribing audio to text
# using AT&T api

require 'json'
require_relative './convert.rb'
require_relative './text2srt.rb'

def send_request
	`curl --request POST \
	--header "Content-Type: application/x-www-form-urlencoded" \
	--header "Accept: application/json" \
	--data "client_id=wujgq7uhb37cfqqzt5dvlyykg6tufvyh&client_secret=59gajhizqxy672iauykyug91idpkxolu&grant_type=client_credentials&scope=SPEECH,STTC,TTS" \
	https://api.att.com/oauth/token`
end

def get_access_token(json)
	hash = Hash.new
	hash = JSON.parse(json)
	hash["access_token"]
end

def send_stuff(token,file)

	`curl --request POST \
	--header "Authorization: Bearer #{token}" \
	--header "Accept: application/json" \
	--header "Content-Type: audio/wav" \
	--header "X-SpeechContext: SMS" \
	--data-binary @#{file} \
	https://api.att.com/speech/v3/speechToText
	`
end

def get_text(json)
	hash = Hash.new
	hash = JSON.parse(json)
	hash["Recognition"]["NBest"][0]["ResultText"]
end

def run_audio2text(file, language)
	resp = send_request
	token = get_access_token(resp)
	text_resp = send_stuff(token, file)
	text = get_text(text_resp)
	processed_text = text.gsub("'", "")
	text << `t #{language} #{processed_text}`
	translated_text = text.split("Translation: ").last.to_s
	if(translated_text.include? "Translit:")
		translated_text = translated_text.slice(0..translated_text.index("\nTranslit:"))
	end
	translated_text
end
