#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'


get "/" do
  erb :index
end

get "/contact" do
  erb :contact
end

post "/contact" do

    @login       = params[:login]
    @email       = params[:email]
    @psw         = params[:psw]
    @psw_repeat  = params[:psw_repeat]


    if @psw != @psw_repeat
      @alert_psw = " <p style='color:red'>Введите повторный пароль!!!</p>"
      erb :contact
    else

      erb :welcome

    end

    # if @login == "admin" and @password == "1"
    #   # @check = @password.class
    #   erb :welcome
    # end

    # redirect "/contact"

end

get "/welcome" do
  @alert_psw = "Введите повторный пароль"
  erb :welcome
end
