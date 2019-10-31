#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'


get "/" do
  @title = "Гостевая книга"
  erb :index
end

def under_construction
  @back = "<p>Under construction</p><a href='/'> back</a>"
end

get "/about" do
  under_construction
end

get "/blog" do
  under_construction
end

get "/portfolio" do
  under_construction
end

get "/contact" do
  erb :contact
end

post "/contact" do

    # registration
    @login       = params[:login]
    @email       = params[:email]
    @psw         = params[:psw]
    @psw_repeat  = params[:psw_repeat]

    # проверка паролей на тип что ввожу
    @check1 = @psw.class
    @check2 = @psw_repeat.class
    @check3 = @psw
    @check4 = @psw_repeat

    # условия на проверку введенных данных
    if @psw != @psw_repeat
      @alert_psw = " <p style='color:red'>Пароль не совпадает!!!</p>"
      erb :contact
    else
      # @welcome = "Проверка прошла успешно!"
      # erb :welcome
    end

end

get "/admin" do
  erb :admin
end

post "/admin" do

  @login       = params[:login]
  @psw         = params[:psw]
  @psw_repeat  = params[:psw_repeat]


  # проверка на совпадения пароля
  if @psw != @psw_repeat
    @alert_psw = " <p style='color:red'>Пароль не совпадает!!!</p>"
    erb :admin
  else
      # проверка на вход пароля
      if @login == "admin" and @psw == "123"
        @welcome = "Проверка прошла успешно! #{under_construction}"
        # .....

        erb :welcome
      else
        @access = " <p style='color:red'>Access denied</p>"
        erb :admin
      end
  end

end

get "/welcome" do

  erb :welcome

end
