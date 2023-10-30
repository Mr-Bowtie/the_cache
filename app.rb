# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'dotenv/load'
require 'pry'
Dotenv.load('.env')

get '/' do
  erb :index
end

get '/npcs' do
  @npcs = Dir.entries('./records/npcs').reject { |f| File.directory? f }
  erb :npcs
end

get '/npcs/:title' do
  @type = 'npcs'
  @content = File.read("./records/npcs/#{params[:title]}")
  @title = params[:title]
  erb :show_content
end

get '/adventure_logs' do
  @adventure_logs = Dir.entries('./records/adventure_logs').reject { |f| File.directory? f }
  erb :adventure_logs
end

get '/adventure_logs/:title' do
  @type = 'adventure_logs'
  @content = File.read("./records/adventure_logs/#{params[:title]}")
  @title = params[:title]
  erb :show_content
end

get '/locations' do
  @locations = Dir.entries('./records/locations').reject { |f| File.directory? f }
  erb :locations
end

get '/locations/:title' do
  @type = 'locations'
  @content = File.read("./records/locations/#{params[:title]}")
  @title = params[:title]
  erb :show_content
end

get '/new_record' do
  erb :new_record
end

get '/edit_record/:type/:title' do
  @type = params[:type]
  @content = File.read("./records/#{params[:type]}/#{params[:title]}")
  @title = params[:title]
  erb :edit_record
end

post '/create_file' do
  file_path = "./records/#{params[:type]}/#{params[:title]}.txt"
  File.open(file_path, 'w') do |file|
    file.write(params[:content])
  end
  redirect "/#{params[:type]}"
end

post '/edit_file' do 
  unless (params[:old_title] == params[:title]) 
    File.rename("./records/#{params[:type]}/#{params[:old_title]}.txt", "./records/#{params[:type]}/#{params[:title]}.txt")
  end

  file_path = "./records/#{params[:type]}/#{params[:title]}.txt"
  File.open(file_path, 'w') do |file|
    file.write(params[:content])
  end
  redirect "/#{params[:type]}"
end
