import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportProvider {
 static Future<void> makeACall(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final Uri uri = Uri.parse("tel:+918507536900");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to make call")),
      );
    }
  }

 static Future<void> sendEmail() async {
   final uri = Uri.parse(
     "mailto:zaykazone.project@gmail.com?subject=Support Request",
   );
   if (await canLaunchUrl(uri)) {
     await launchUrl(uri);
   }
 }

 static Future<void> openMap() async {
   final uri = Uri.parse(
     "https://www.google.com/maps/search/?api=1&query=Food+Plaza+Mumbai",
   );
   if (await canLaunchUrl(uri)) {
     await launchUrl(uri, mode: LaunchMode.externalApplication);
   }
 }

}
