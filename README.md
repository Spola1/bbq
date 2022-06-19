# BBQ

![RubyOnRails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
**7.0.2**


![Ruby](https://img.shields.io/badge/Ruby-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) 
**3.0.2**

### Приложение в котором вы можете организовывать события, делиться фотографиями и впечатлениями.


#### Запуск программы:

* Скопируйте репозиторий:

```
git clone git@github.com:Spola1/bbq.git
```

* Войдите в папку с программой:

```
cd ./bbq
```

* Установите библиотеки:

```
bundle install
```

* Запустите миграции:

```
rails db:migrate
```

* Соберите стили приложения:

```
yarn install
```

```
yarn build
```

```
yarn build:css
```

* Запустите сервер:

```
rails s
```


### Реализованный функционал:

- Authorization (Pundit)
- OAuth (Vkontakte, Github)
- 2 languages (ru, en), i18n
- Event: creating, editing, deleting
- Possibility to set a pin-code for private access
- Comments to the event
- Subscription to the event
- Sending email
- Uploading files and a gallery of event photos (carrierwave, lightbox)
- Authentication, Sessions (Devise)

### Стили страниц: 

Bootstrap 5.1.3

### Тесты:

Rspec
