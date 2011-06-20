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
  set :mongo, Mongo::Connection.new('localhost', 27017, :pool_size => 20,:timeout => 100)
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
get '/:name/api.json' do
  mikoshi = settings.mongo.db('test').collection(params[:name])
  results = mikoshi.find({},{:sort=>['time', 'descending'], :limit=>settings.config['pager_num']})
  resp = []
  results.each do |row|
    row.delete('_id')
    resp.push(row)
  end
  return JSON.dump(resp)
end
# save one of mikoshi status to mongodb
post '/:name/api.json' do
  hash = JSON.parse(request.body.string)
  if hash['pass'] == settings.config['pass']
    hash.delete('pass')
    hash['updated_at'] = Time.now.to_i.to_s
    mikoshi = settings.mongo.db('test').collection(params[:name])
    mikoshi.insert(hash)
    return "{'result': 'succeed'}"
  else
    halt 401, "{'result': 'failed', 'reason':'invalid pass'}"
  end
end





