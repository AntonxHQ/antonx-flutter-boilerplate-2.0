# AntonX Flutter Template

## Initial check points

Few things to make sure before using this template:

- Update your version to Flutter V3.0.0


## Initial App Flow settings

All initial app settings are done in `_initialSetup();` function on Splash Screen with the following flow:

- Init localStorageService
- Check internet connectivity
- Configure notifications service
- Get onboarding data (if onboarding is dynamic otherwise it's removed)
- Check if onboarding was complete (if not go to relevant onboarding screen otherwise move further)
- Do authentication setup with the following steps
  - Check if user is logged in by checking the access_token
  - If logged in then get user data and also update users FCM token
- Check if user is logged-in, move to root screen (home) otherwise move to login screen.




## Logging

For logging make sure the following steps:

- Never use print statement directly for logs
- For logging use `CustomLogger`.
- In `CustomLogger` the className is the name of the class from where we are generating the logs. It helps us identity the location from where the logs are being generated.
Here is an example as well:

```dart
class TestClass{
final log = CustomLogger(className: 'TestClass');

doSomeWork(){
  log.i('@doSomeWork: Testing info logs'); // Use it to log information
  log.d('@doSomeWork: Testing debug logs'); // Use it to log debug messages
  log.e('@doSomeWork: Testing error logs'); // Use it to log error messages
  log.wtf('@doSomeWork: Testing WTF logs'); // Use it to log critical error messages
  }
}
```

## Onboarding

For onboarding, we have two options. One is dynamic (onboarding data coming from a remote server via REST Apis) and other is static (in most cases we prefer static as it's experience is pretty smooth).

So if dynamic onboarding is used then there is implementation done on splash screen and here is line calling onboarding data function:

```dart
onboardingList = await _getOnboardingData();
```

After getting data from a remote server or using local server, we use local_storage (Shared Preferences) to store user onboarding status (record the screen number that user already went through) and then next time when the user comes back to the app, we show data to the user accordingly. And you can find the implementation in this code on Splash Screen.

```dart
if (_localStorageService.onBoardingPageCount + 1 < onboardingList.length) {
      ///
      /// For better user experience we precache onboarding images in case
      /// they are coming from a remote server. 
      /// Remove it if onboarding is static.
      ///
      final List<Image> preCachedImages =
          await _preCacheOnboardingImages(onboardingList);
      await Get.to(() => OnboardingScreen(
          currentIndex: _localStorageService.onBoardingPageCount,
          onboardingList: onboardingList,
          preCachedImages: preCachedImages));
      return;
    }
```

## API responses

## Features List

AntonX starter app to speedup our development process by adding a list of most commonly used features directly here.
The features already added include:

- Optimized Project Structure
- App initial flow settings
- Local Storage (SharedPrefs) complete settings
- Screen Utils settings for adoptive design
- Dependency injection settings with get_it package
- Firebase Integration settings
- Notifications using Firebase Cloud Messaging
- Rest APIs Integration settings:
  - APIs Services file with the boilerplate code
  - Response handling settings
- Onboarding flow settings
- Authentication settings:
  - Login with email & password REST APIs
  - Signup with email & password REST APIs
  - Forgot password settings with REST APIs
  - Login with Gmail (In progress)
  - Login with Apple (In Progress)
  - Login with Facebook (In Progress)
- Google maps integration
- Location services:
  - Getting user permissions and it's handling
  - Getting user location and it's handling
- Pin location on map implementation
- File picker services
  - Image picker (Compression quality etc)
  - File picker
  - .heic to jpg conversion
- Localization services
- Custom logger for better debugging

Future planned features:

- Build flavours
- CI/CD
- ...
- ...

Everyone is mostly welcomed to request a feature in the issues section if you thinks it's worthy adding.
