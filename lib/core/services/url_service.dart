import 'package:url_launcher/url_launcher.dart';

class UrlService {
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      return true;
    } else {
      return false;
    }
  }
}
