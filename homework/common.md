
# Домашние задания

Домашние работы будут выполняться в одном проекте, который будет разрастаться по мере прохождения новых тем. Основная тема проекта — похожее на Instagram приложение.

## Общие требования:

-   проект должен собираться, приложение должно запускаться на симуляторе iPhone с iOS 14+
-   код должен быть читаемым и понятным для проверяющих
-   код должен сопровождаться комментариями, которые описывают причину выбора такого или иного подхода
-   соблюдайте гайдлайны ([https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html), [https://developer.apple.com/design/human-interface-guidelines/ios/overview/themes/](https://developer.apple.com/design/human-interface-guidelines/ios/overview/themes/))
-   UI должен корректно отображаться на всех устройствах, поддерживающих iOS14+
-   в качестве результата проделанной работы ожидаем ссылку на PR в вашем репозитории

## Флоу для разработки на примере первой домашней работы:

Создать ветку `feature/lesson1`

    git pull
    git checkout master
    git checkout -b feature/lesson1
    git push origin feature/lesson1

При работе с кодом заносить изменения в локальную ветку с помощью команды:

    git add .
    git commit -m '... Your comment text here ...'


После выполнения работы над задачей слить код в репозиторий:

    git pull
    git checkout develop
    git merge feature/lesson1

Далее создать Pull-Request через браузер и назначить на него ответственным нашего ревьювера:

https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request

Документация по gitflow:

https://www.atlassian.com/ru/git/tutorials/comparing-workflows/gitflow-workflow
