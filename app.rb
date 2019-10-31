#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

def under_construction
  @back = "<p>Under construction</p><a href='/'> back</a>"
end

get "/" do
  @title = "Гостевая книга"
  erb :index
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

# contact reg panel
get "/contact" do
  erb :contact
end

########################### РЕГИСТРАЦИЯ АККАУНТА ##########################
# регистрация пользователя в гостевой книги

post "/contact" do

    @login       = params[:login]
    @email       = params[:email]
    @phone       = params[:phone]

    # условия на проверку введенных данных
    if @psw != @psw_repeat
      @alert_psw = " <p style='color:red'>Пароль не совпадает!!!</p>"
      erb :contact
    else

      File.open("./public/users.txt", "a") do |file|
         file.puts "login: #{@login}, phone: #{@phone}, mail:#{@email}, date message: #{Time.now}"
      end

      @reg_user = "login: #{@login}, phone: #{@phone}, mail:#{@email}, date_time: #{Time.now}"
      erb :complete
    end
end

########################### Админ панель ##########################
get "/admin" do
  erb :admin
end

# админ запрос чтение файла users и messages
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
        File.open("./public/users.txt", "r") do |line|
                @logfile = line.readlines
        end

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

####################### ЗАПИСЬ СООБЩЕНИЯ ПОЛЬЗОВАТЕЛЯ #########################

get "/message" do
  erb :message
end

# запись сообщения пользователя
post "/message" do

  @login       = params[:login]
  @email       = params[:email]
  @phone       = params[:phone]
  @message     = params[:message]

    File.open("./public/messages.txt", "a") do |file|
       file.puts "login: #{@login}, mail:#{@email}, date message: #{Time.now},
       message #{@message}"
    end

    @mes_complete = "Сообщение записано!!!"
    erb :complete

end
