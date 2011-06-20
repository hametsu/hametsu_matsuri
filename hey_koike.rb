#!/usr/bin/env ruby
# -*- coding: japanese-cp932 -*-
# author: takano32 <tak at no32.tk>
#

require 'rubygems'
require 'mechanize'
require 'uri'


class HeyKoike
	URI = URI.parse(%q!http://kamome.2ch.net/test/read.cgi/art/1308547784/!)
	def initialize
		@agent = Mechanize.new
		@agent.user_agent_alias = 'Mac Safari'
	end

	def say(message)
		response = @agent.get(URI + "l50")
		form = response.forms.first
		form['mail'] = 'sage'
		form['MESSAGE'] = message
		response = @agent.submit(form)
		form = response.forms.first
		response = @agent.submit(form)
		puts response.body
	end
	
end


if __FILE__ == $0 then
	hk = HeyKoike.new
	while(sleep 1) do
		ch = %w(Ç® Ç¢ ÅA è¨ ír ÅI).shuffle.first
		hk.say(ch)
		puts ch
		exit
	end
end



