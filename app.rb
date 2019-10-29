#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

# подгружаем библиотеку sqlite3
require 'sqlite3'


get "/" do
  erb :index
end
