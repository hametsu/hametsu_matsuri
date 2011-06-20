# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'haml'
require 'pit'
require 'json'
require 'mongo'

configure do
	use Rack::Session::Cookie, :secret => Digest::SHA1.hexdigest(rand.to_s)
	set :config, YAML.load_file("config.yaml")
  set :dbname, "matsudo_matsuri_201106"
  set :pager_num, 20
end


# root
get '/' do
end


# return the view of mikoshi maps for PC
get '/mikoshi/maps' do
end
# return the view of mikoshi maps for ketai
get '/mikoshi/maps_mobile' do
end



# return newest mikoshi statuses as JSON
get '/mikoshi/api.json' do
  coll = Mongo::Connection.new.db(options.dbname).collection("mikoshi")
  results = coll.find({},{:sort=>['id', 'descending'], :limit=>options.pager_num})
  json = JSON.dump(results)
  return json
end
# save one of mikoshi status to mongodb
post '/mikoshi/api.json' do
  hash = JSON.parse(request.body.string)
  if hash['pass'] == options.config['pass']
    coll = Mongo::Connection.new.db(options.dbname).collection("mikoshi")
    coll.insert(hash)
    return "{'result': 'succeed'}"
  else
    halt 401, "{'result': 'failed', 'reason':'invalid pass'}"
  end
end





