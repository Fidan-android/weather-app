# weather_app

Тестовое задание Wether App

## Инструкция к запуску
flutter clean
flutter pub get
flutter run (для генерации apk запросить weather.jks)

## Используемые технологии
riverpod - позволяет сразу реализовать di и подписываться на изменения 
shared_preferences - доступ к локальному хранилищу
cached_network_image - вывод изображений по ссылке, но при этом позволяет закэшировать и управлять состоянием
dio - легкая настройка для запросов к апи и interceptor'ов
connectivity_plus - легкий способ отслеживания интернета
go_router - навигация в приложении
json_annotation - позволяет сгенерировать методы для сериализации и десериализации моделей в json и наоборот


## Известные ограничения и что бы добавил
connectivity_plus - не полностью проверяет наличие интернета, поменять на другую библиотеку
riverpod - заменить на mobX
shared_preferences - заменить на hive
dio - поменять на chopper


## Экран поиска городов
<img src="/assets/readme/screen1.png" alt="Описание" height="200"/>

## Экран текущей погоды

<img src="/assets/readme/screen2.png" alt="Описание" height="200"/>

## Экран погоды за 5 дней

<img src="/assets/readme/screen3.png" alt="Описание" height="200"/>

## Экран с ошибкой об отсутствии интернет

<img src="/assets/readme/screen4.png" alt="Описание" height="200"/>
