#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

=begin
Инициализация приложения в синтатре происходит в
 configure do ... end.
configure функция запускается каждый раз,
 при перезагрузки приложения.
=end
def get_db
  return SQLite3::Database.new("Guestbook_users.db")
end

def get_db_m
  return SQLite3::Database.new("Guestbook_messages.db")
end

configure do
  # сделать базу данных с двумя таблицами
  # users и messages при регистрации

  # db = SQLite3::Database.new("Guestbook.db")
  @db = get_db
  @db_m = get_db_m

  # создание базы данных, если она не существует
  @db.execute 'CREATE TABLE IF NOT EXISTS
              "Users"
            (
              "id" INTEGER PRIMARY KEY AUTOINCREMENT,
              "login" TEXT,
              "email" TEXT,
              "phone" TEXT,
              "datestamp" TEXT
            )'

  @db_m.execute 'CREATE TABLE IF NOT EXISTS
              "Messages"
            (
              "id" INTEGER PRIMARY KEY AUTOINCREMENT,
              "login" TEXT,
              "email" TEXT,
              "message" TEXT,
              "datestamp" TEXT
            )'
  # @db.close
end

# метод отображения на 3 вкладках предупреждения
def under_construction
  @back = "<p>Under construction</p><a href='/'> back</a>"
end

get "/" do
  # передаем заголовок страницы
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

# отображения страницы контакт рег формы
get "/contact" do
  erb :contact
end

########################### РЕГИСТРАЦИЯ АККАУНТА ##########################
# регистрация пользователя в гостевой книги

post "/contact" do

    @login       = params[:login]
    @email       = params[:email]
    @phone       = params[:phone]
    # @dat        = Time.now
    @date        = params[:date]
  # условия на проверку введенных данных
    # .....
# "Id" INTEGER PRIMARY KEY AUTOINCREMENT,
  db = get_db
  db.execute 'INSERT INTO Users
								(
                  login ,
									email ,
									phone ,
									datestamp
                )
                values(?,?,?,?)', [@login, @email, @phone, @date]

    @reg_user = "login: #{@login}, phone: #{@phone}, mail:#{@email}, date_time: #{@date}"
    erb :complete
end

########################### АДМИН ПАНЕЛЬ ##########################
# отображение страницы админ
get "/admin" do
  erb :admin
end

# админ пост запрос чтение файла users и messages
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

        # отображение базы данных с двуми таблицами в админ панели

        # users file
        @db = get_db
        @users = @db.execute "SELECT * FROM 'Users'"

        # messages file
        # .............
        @db_m = get_db_m
        @messages = @db_m.execute "SELECT * FROM 'Messages'"


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
  # @phone       = params[:phone]
  @date        = params[:date]
  @message     = params[:message]

    db_m = get_db_m
    db_m.execute 'INSERT INTO Messages
  								(
                    login ,
  									email ,
  									datestamp ,
  									message
                  )
                  values(?,?,?,?)', [@login, @email, @date, @message]


    @mes_complete = "Сообщение записано!!!"
    erb :complete

end
