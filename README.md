# AntonX Flutter Template

## Initial check points

Few things to make sure before using this template:

- Update your version to Flutter V3.0.0

## Logging

For logging make sure the following steps:

- Never use print statement directly for logs
- For logging use `CustomLogger` and here is an example as well:

`final log = CustomLogger(className: 'main');
log.i('Testing info logs'); // Use it to log information
log.d('Testing debug logs'); // Use it to log debug messages
log.e('Testing error logs'); // Use it to log error messages
log.wtf('Testing WTF logs'); // Use it to log critical error messages
`

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
