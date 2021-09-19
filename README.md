# Выпускной проект Школы IOS Сбербанка.

[![rounded-in-photoretrica-2.png](https://i.postimg.cc/HnhpFKw4/rounded-in-photoretrica-2.png)](https://postimg.cc/0K7RwVHb)

## Описание
С помощью приложения Варка, Вы можете отсканировать штрих-код продукта и получить краткую инструкцию по его приготовлению. Если продукта еще нет в базе, приложение предложит добавить его самостоятельно, чтобы в дальнейшем, вы и другие пользователи смогли его приготовить. <br>

## Процесс взаимодействия
Приложение состоит из двух основных экранов:<br>
-**Как варить**<br>
-**Недавние продукты**<br>
При первом запуске информация о продукте будет отсутствовать, об этом вам сообщит маскот.<br>
На экране “Недавние продукты”, вы можете увидеть(добавленные для демонстрации работы приложения) продукты.

[![ezgif-com-gif-maker.gif](https://i.postimg.cc/tCQ4jZcy/ezgif-com-gif-maker.gif)](https://postimg.cc/rzjkGmcY)

### Сканирование 
Попробуем нажать на центральную кнопку и отсканировать продукт. 

[![ezgif-com-gif-maker-1.gif](https://i.postimg.cc/kG5zrcdw/ezgif-com-gif-maker-1.gif)](https://postimg.cc/nj60BqrQ)

### Приготовление
Получив необходимые данные из базы, можно приступить к приготовлению, нажав на кнопку “Начать готовить”<br>
На экране появится инструкция с описанием процесса приготовления, количеством необходимой воды, временем варки и дополнительными нюансами, связанными с этим продуктом.

[![ezgif-com-gif-maker.gif](https://i.postimg.cc/tJ2DTb3z/ezgif-com-gif-maker.gif)](https://postimg.cc/SYYcTwtX)

### Таймер
На одном из этапов приготовления, пользователю предлагается завести таймер, с заранее настроенным временем, для этого необходимо нажать на кнопку “Таймер” и через указанное время, пользователь получит уведомление с характерным звуковым сигналом. 

[![ezgif-com-gif-maker.gif](https://i.postimg.cc/rFC21ZcX/ezgif-com-gif-maker.gif)](https://postimg.cc/Cz12YNzm)

Также реализована возможность продлить готовку еще на 1 и 5 минут, непосредственно из всплывающего уведомления. 

![ezgif-com-gif-maker.gif](https://media.giphy.com/media/jL92SNuuolJU4SRBFW/giphy.gif?cid=790b7611816f0be15681e6c1f6b27bfae7f45b497fcc3030&rid=giphy.gif&ct=g)

### Добавление нового продукта 
Если найти продукт не удалось, появляется Alert с предложением о добавлении продукта вручную. <br> 
После заполнения всех необходимых полей валидными значениями, продукт будет добавлен в общую базу, а пользователь получит уведомление.

[![ezgif-com-gif-maker-2.gif](https://i.postimg.cc/dVk0LHxy/ezgif-com-gif-maker-2.gif)](https://postimg.cc/QFDDzbs8)

### Недавние продукты 
Здесь отображаются продукты, которые пользователь уже отсканировал или добавил в базу.<br> 
Если нажать на один из продуктов, отобразится более подробная информация с инструкцией для приготовления. 

[![ezgif-com-gif-maker-3.gif](https://i.postimg.cc/wj3rhx3b/ezgif-com-gif-maker-3.gif)](https://postimg.cc/QFGSD3Qp)

## Особенности реализации 

-**Не испльзуются публичные API**<br>
-**Идея приложения, а также весь UX/UI, разработан самостоятельно**<br>
-**В качестве Backend сервиса ипользуется FireBase**<br>
-**Элемент, отвечающий за отображения Таймера, написан на SwiftUI**<br>

[![1.jpg](https://i.postimg.cc/pXcz4zJk/1.jpg)](https://postimg.cc/7f75TCcT)

-**На экране добавления продукта, реализован Custom ToolBar для более удобного перемещения между полями ввода.
В некоторых TextField вместо клавиатуры появляется UIPickerView, с категориями, получаемыми из базы**<br>

[![ezgif-com-gif-maker-4.gif](https://i.postimg.cc/QNvvZ4kn/ezgif-com-gif-maker-4.gif)](https://postimg.cc/Hj46QtNQ)

-**В зависимости от модели телефона, внешний вид TabBar, будет меняться**<br>

[![2.jpg](https://i.postimg.cc/SQ7dKgWK/2.jpg)](https://postimg.cc/WtzgW6YR)

## Архитектура

* ViewController содержит только UI и Анимации, вся логика вынесена во ViewModel.
* ViewController держит ссылку на ViewModel, обновление происходит через DataBinding, обратная ссылка отсутствует.
* BaseViewModel и все необходимые сервисы инициализируются сущностью Coordinator в момент запуска приложения и далее передаются от одной ViewModel к другой.
* ViewController инициализирует следующий ViewController, запрашивая необходимую ViewModel  у своей, управляющей ViewModel. 

[![My-First-Board-1.jpg](https://i.postimg.cc/1RCNHzND/My-First-Board-1.jpg)](https://postimg.cc/23W6jrG5)

## Тесты

* Тестовое покрытие Unit-тестами составляет 11.7%
* Добавлен один UI-тест
* Добавлен один Snapshot-тест

[![2.jpg](https://i.postimg.cc/mgYdhnmX/2.jpg)](https://postimg.cc/qN7c51Vy)

## Требования к проекту

| Требование | Выполнение | Примечания | 
|----------------|---------------|---------------|
| Использовать Core Data для хранения моделей данных|✅| Хранение уже отсканированных продуктов, осуществляется по средствам CoreData|
| Использовать KeyChain/UserDefaults для пользовательских настроек |✅|Только при первом запуске, добавляется набор продуктов для демонстрации работы приложения. Состояние сохраняется в UserDefaults|
| Использование Swift styleguides (Google styleguides) |✅||
| Не использовать сторонние библиотеки (кроме snapshot-тестов) |✅||
| Использовать сеть |✅|Backend-сервис реализован на основе FireBase|
| Отображение медиа (аудио, видео, изображения) из сети |✅|Добавлена специальная пасхалка|
| Минимальное количество экранов: 3 |✅|Общее количество экранов: 5|
| Обязательно использовать UINavigationController/TabBarController|✅|Реализован кастомный TabBar|
| Deployment Target: iOS 13|✅||
| Покрытие модульными тестами 10% и более |✅|11.7%|
| Хотя бы один UI-тест через page object |✅||
| Хотя бы один snapshot тест для iPhone SE (разрешается использовать внешнюю библиотеку) |✅||
| Использование Архитектурных подходов и шаблонов проектирования|✅|MVVM|
| Верстка UI в коде |✅||
| Обязательно использовать UITableView/UICollectionView |✅||
| Кастомные анимации |✅||
| Swiftlint |✅||

## P.S.

 Для активации пасхалки, необходимо открыть экран с таймером, нажать на пустую область над экраном и держать нажатой 3 секунды.












