Для работы API в режиме, когда приложение выгружено необходимо :

1. В настройках проекта, на закладке Capabilities в секции Background Modes установить Location updates
2. В файле настроек Info.plist небходимо указать, что работа использование геолокации разрешено все время 	

```
        <key>NSLocationAlwaysUsageDescription</key>
        <string>This program requires background permission to monitor regions.</string>
```

В исходный код включена лицензия на полный функционал API со сроком действия до 27 июля 2016 г.

Строка лицензии:

```
AwHQNNmTV+LNa2N9McWVRlg2odUKSlUNX8ni6L66YeCUjbI5SYYUabNpi14VfzOei9Cbwe/XEyqa6LyhbItwJHAqBLMZ+ljY4O2wRYI0PHkloC4c2rf0H3P73CBIt5UY3qg=
```
