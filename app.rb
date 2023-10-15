# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'dotenv/load'
Dotenv.load('.env')

get '/' do
  erb :index
end

get '/npcs' do
  @npcs = Dir.entries('./files/npcs').reject { |f| File.directory? f }
  erb :npcs
end

get '/npcs/:title' do
  @content = File.read("./files/npcs/#{params[:title]}")
  puts params[:title]
  @title = params[:title]
  erb :show_content
end

get '/adventure_logs' do
  @adventure_logs = Dir.entries('./files/adventure_logs').reject { |f| File.directory? f }
  erb :adventure_logs
end

get '/adventure_logs/:title' do
  @content = File.read("./files/adventure_logs/#{params[:title]}")
  puts params[:title]
  @title = params[:title]
  erb :show_content
end

get '/locations' do
  @locations = Dir.entries('./files/locations').reject { |f| File.directory? f }
  erb :locations
end

get '/locations/:title' do
  @content = File.read("./files/locations/#{params[:title]}")
  puts params[:title]
  @title = params[:title]
  erb :show_content
end

get '/rich_text_form' do
  erb :rich_text_form
end

post '/create_file' do
  file_path = "./files/#{params[:type]}/#{params[:title]}.txt"
  File.open(file_path, 'w') do |file|
    file.write(params[:content])
  end
  redirect "/#{params[:type]}"
end
