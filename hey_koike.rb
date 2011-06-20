#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# author: takano32 <tak at no32.tk>
#

require 'rubygems'
require 'mechanize'
require 'uri'


class HeyKoike
	URI = URI.parse(%q!http://kamome.2ch.net/test/read.cgi/art/1308547784/!)
	def initialize
		@agent = Mechanize.new
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
	hk.say('はい')
end



