Для работы API в режиме, когда приложение выгружено необходимо :

1. В настройках проекта, на закладке Capabilities в секции Background Modes установить Location updates
2. В файле настроек Info.plist небходимо указать, что работа использование геолокации разрешено все время 	

```
        <key>NSLocationAlwaysUsageDescription</key>
        <string>This program requires background permission to monitor regions.</string>
```
