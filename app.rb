# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'dotenv/load'
Dotenv.load('.env')

get '/' do
  erb :index
end

get '/npcs' do
  @npcs = Dir.entries('./records/npcs').reject { |f| File.directory? f }
  erb :npcs
end

get '/npcs/:title' do
  @content = File.read("./records/npcs/#{params[:title]}")
  @title = params[:title]
  erb :show_content
end

get '/adventure_logs' do
  @adventure_logs = Dir.entries('./records/adventure_logs').reject { |f| File.directory? f }
  erb :adventure_logs
end

get '/adventure_logs/:title' do
  @content = File.read("./records/adventure_logs/#{params[:title]}")
  @title = params[:title]
  erb :show_content
end

get '/locations' do
  @locations = Dir.entries('./records/locations').reject { |f| File.directory? f }
  erb :locations
end

get '/locations/:title' do
  @content = File.read("./records/locations/#{params[:title]}")
  @title = params[:title]
  erb :show_content
end

get '/rich_text_form' do
  erb :rich_text_form
end

post '/create_file' do
  file_path = "./records/#{params[:type]}/#{params[:title]}.txt"
  File.open(file_path, 'w') do |file|
    file.write(params[:content])
  end
  redirect "/#{params[:type]}"
end
