import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  // Hàm gọi điện
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  // Hàm gửi email
  static Future<void> sendEmail(String emailAddress, {String? subject}) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: subject != null ? 'subject=${Uri.encodeComponent(subject)}' : null,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }
}