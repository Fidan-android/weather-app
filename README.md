# weather_app

Тестовое задание Wether App

## Инструкция к запуску
flutter clean
flutter pub get
flutter run (для генерации apk запросить weather.jks)

## Используемые технологии
riverpod - позволяет сразу реализовать di и подписываться на изменения </br>
shared_preferences - доступ к локальному хранилищу</br>
cached_network_image - вывод изображений по ссылке, но при этом позволяет закэшировать и управлять состоянием</br>
dio - легкая настройка для запросов к апи и interceptor'ов</br>
connectivity_plus - легкий способ отслеживания интернета</br>
go_router - навигация в приложении</br>
json_annotation - позволяет сгенерировать методы для сериализации и десериализации моделей в json и наоборот</br>


## Известные ограничения и что бы добавил
connectivity_plus - не полностью проверяет наличие интернета, поменять на другую библиотеку</br>
riverpod - заменить на mobX</br>
shared_preferences - заменить на hive</br>
dio - поменять на chopper</br>


## Экран поиска городов
<img src="/assets/readme/screen1.png" alt="Описание" height="200"/>

## Экран текущей погоды

<img src="/assets/readme/screen2.png" alt="Описание" height="200"/>

## Экран погоды за 5 дней

<img src="/assets/readme/screen3.png" alt="Описание" height="200"/>

## Экран с ошибкой об отсутствии интернет

<img src="/assets/readme/screen4.png" alt="Описание" height="200"/>
