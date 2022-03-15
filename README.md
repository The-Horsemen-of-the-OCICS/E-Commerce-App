# E-Commerce App

An E-Commerce web application developed in Flutter 

## Integration Testing Instruction
- Install ChromeDriver
- install `integration_test` package

Launch WebDriver by 
```
chromedriver --port=${PORT_NUM}
```

Run tests by
```
flutter drive  --driver=test_driver/integration_test.dart   --target=integration_test/${TEST_FILE_NAME}.dart   -d web-server --no-headless --driver-port={PORT_NUM} 
```

e.g
```
chromedriver --port=4444
```
```
flutter drive  --driver=test_driver/integration_test.dart   --target=integration_test/$login_test.dart   -d web-server --no-headless --driver-port=4444 
```