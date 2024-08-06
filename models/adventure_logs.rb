require 'sinatra/activerecord'

class AdventureLog < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :date, presence: true
  validates :session_number, uniqueness: true, numericality: true, allow_blank: true, allow_nil: true
end
