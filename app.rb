# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'dotenv/load'
require 'pry'
Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }

Dotenv.load('.env')

# Create records directories if they doesn't exist
Dir.mkdir('./records') unless Dir.exist?('./records')
Dir.mkdir('./records/npcs') unless Dir.exist?('./records/npcs')
Dir.mkdir('./records/adventure_logs') unless Dir.exist?('./records/adventure_logs')
Dir.mkdir('./records/locations') unless Dir.exist?('./records/locations')

get '/' do
  erb :index
end

# ========== NPCs ==========

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

# ========== Adventure Logs ==========

get '/adventure_logs' do
  # @adventure_logs = Dir.entries('./records/adventure_logs').reject { |f| File.directory? f }
  # erb :adventure_logs

  @adventure_logs = AdventureLog.all
  erb :adventure_logs
end

get '/adventure_logs/:id' do
  @adventure_log = AdventureLog.find(params[:id])
  erb :'adventure_logs/show'
end

get '/adventure_logs/new' do
  erb :'adventure_logs/new', locals: { errors: nil }
end

post '/adventure_logs/create' do
  # define exactly what param elements we want to use to prevent any other value being set by users
  @adventure_log = AdventureLog.new(adventure_log_params)

  if @adventure_log.save
    redirect "/adventure_logs/#{@adventure_log.id}"
  else
    erb :'adventure_logs/new', locals: { errors: @adventure_log.errors }
  end
end

get '/adventure_logs/:id/edit' do
  @adventure_log = AdventureLog.find(params[:id])
  erb :'adventure_logs/edit', locals: { errors: nil }
end

patch '/adventure_logs/:id' do
  @adventure_log = AdventureLog.find(params[:id])

  if @adventure_log.update(adventure_log_params)
    redirect "/adventure_logs/#{@adventure_log.id}"
  else
    erb :'adventure_logs/edit', locals: { errors: @adventure_log.errors }
  end
end

def adventure_log_params
  {
    title: params[:title],
    date: params[:date],
    session_number: params[:session_number],
    content: params[:content]
  }
end

# ========== Locations ==========

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

# =============== old file manip methods ===============

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
  # file_path = "./records/#{params[:type]}/#{params[:title]}.txt"
  # File.open(file_path, 'w') do |file|
  #   file.write(params[:content])
  # end
  # redirect "/#{params[:type]}"
end

post '/edit_file' do
  unless params[:old_title] == params[:title]
    File.rename("./records/#{params[:type]}/#{params[:old_title]}.txt",
                "./records/#{params[:type]}/#{params[:title]}.txt")
  end

  file_path = "./records/#{params[:type]}/#{params[:title]}.txt"
  File.open(file_path, 'w') do |file|
    file.write(params[:content])
  end
  redirect "/#{params[:type]}"
end
