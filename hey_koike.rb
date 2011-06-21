#!/usr/bin/env ruby
# -*- coding: sjis -*-
# author: takano32 <tak at no32.tk>
#

require 'rubygems'
require 'mechanize'
require 'hpricot'
require 'uri'

class HeyKoike
	Mechanize.html_parser = Hpricot
	URI = URI.parse(%q!http://ssig33.com/!)
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
		ch = %w(?? ?? ?A ?? ?r ?I).shuffle.first
		hk.say(ch)
		puts ch
	end
end



