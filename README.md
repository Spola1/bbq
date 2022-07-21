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

* Cкопируйте названия ключей из .env.example в свой файл .env и пропишите свои данные

```
cp .env.example .env
```

>__.env__
>```
>  MAILJET_API_KEY=
>  MAILJET_SECRET_KEY=
>  MAILJET_SENDER=
>
>  MAIL_PASSWORD=
>
>  MAPBOX_TOKEN=
>
>  POSTGRES_PASSWORD=
>
>  OMNIAUTH_GITHUB_ID_PROD=
>  OMNIAUTH_GITHUB_KEY_PROD=
>
>  OMNIAUTH_VK_ID_PROD=
>  OMNIAUTH_VK_KEY_PROD=
>
>  YANDEX_MAPS_API_KEY=
>
>  YC_ACCESS_KEY_ID=
>  YC_SECRET_ACCESS_KEY=
>```

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

- Авторизация (Pundit)
- Вход через соц.сети (Vkontakte, Github)
- Интернационализация (ru, en), i18n
- Событие: создание, редактирование, удаление
- Пин-код для события
- Комментарии для события
- Подписки на событие
- Отправка почты (mailjet)
- Загрузка фотографий (carrierwave, lightbox)
- Аутентификация (Devise)
- Панель администратора (rails_admin)

### Стили страниц: 

Bootstrap 5.1.3

### Тесты:

Rspec
