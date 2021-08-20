//
//  Inscriptions.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 01.07.2021.
//

enum Inscriptions {
    static let addNewProductVCStoryBoardID = "addNewProductVC"
    static let unwindToProductInfoSegueID = "unwindToProductInfo"
    static let productInfoCollectionViewReuseID = "ProductInfoCollectionViewCell"
    static let tabBarItemLeftTitle = "Как варить"
    static let tabBarItemRightTitle = "Недавние"
    static let barCodeAlertTitle = "Хьюстон, у нас проблемы"
    static let barCodeAlertMessage = "Кажется, данного продукта еще нет в базе, вы можете нам помочь и добавить его вручную"
    static let barCodeAlertButtonOkTitle = "Добавить"
    static let barCodeAlertButtonCancelTitle = "Потом"
    static let identifierOfTimerNotification = "timer"
    static let titleOfTimerNotification = "Таймер"
    static let bodyOfTimerNotification = "Приготовление закончено. Не забудьте выключить плиту и слить воду"
    static let identifierSnoozeOneMinuteButton = "snoozeOneMinute"
    static let titleSnoozeOneMinuteButton = "Готовить еще минуту"
    static let identifierSnoozeFiveMinuteButton = "snoozeFiveMinutes"
    static let titleSnoozeFiveMinuteButton = "Отложить на 5 минут"
    static let identifierTurnOffTimerButton = "turnOff"
    static let titleTurnOffTimerButton = "Выключить"
    static let identifierOfAddedProductNotification = "productWasAdded"
    static let titleOfAddedProductNotification = "Новый продукт добавлен в базу"
    static let bodyOfAddedProductNotification = "Ура! Вы добавили новый продукт в базу и помогли нам стать лучше, спасибо!"
    static let titleNotificationsAreNotAvailableAlert = "Внимание!"
    static let messageNotificationsAreNotAvailableAlert = "Уведомления выключены. Пожалуйста, включите их, или мы не сможем сообщить о готовности продукта"
    static let okActionNotificationsAreNotAvailableAlert = "Включить уведомления"
    static let cancelActionNotificationsAreNotAvailableAlert = "Не хочу"
    static let categoryIdentifierTimerNotification = "timerActions"
    static let IncorrectValidationAlertTitle = "Упс..."
    static let variantsOfWaterRatio = ["🍚 1 : 1💧", "🍚 1 : 2💧", "🍚 1 : 3💧", "🍚 1 : 4💧", "🍚 1 : 5💧"]
    static let titleOfDoneButtonForKB = "Сохранить"
    static let messageOfStillEmptyView = "Здесь пока ничего нет. Попробуйте что-нибудь отсканировать или выбрать из недавних продуктов"
    static let recentProductCollectionViewCellId = "RecentProductCollectionViewCell"
    static let messageRecentProductNotFound = "В недавних продуктах ничего не найдено. Попробуйте что-нибудь отсканировать."
    static let recentProductTitle = "Недавние продукты"
    static let instructionOfCookingFirstStep = "Подготовьте продукты, начинаем готовить"
    static let instructionOfCookingSecondStep = "Наполните кастрюлю водой, в соотношении с продуктом"
    static let instructionOfCookingThirdStep = "Дождитесь закипания воды"
    static let instructionOfCookingFourthStep = "Опустите продукт в кипящую воду. Нажмите на таймер 👇🏻"
    static let instructionOfCookingFifthStep = "Слейте воду"
    static let instructionOfCookingSixthStep = "Добавьте по вкусу соль, перец, масло. Приятного аппетита!"
    
}
