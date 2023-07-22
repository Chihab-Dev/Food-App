import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class Fcm {
  Future<Response> sentPushNotification(String token, String notificationBody) async {
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var body = {
      "to": token,
      "notification": {
        "title": "Food App",
        "body": notificationBody,
      },
    };

    var response = await post(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            'key=AAAAuXGGEq4:APA91bGqNGaddraWllOGyU7_UjQTx4Log8Y8tTlhNzqdvjWdS3mc-H4c6Con1cKpVX9tMBeDy-qaInuaeAz01QYRgmTFOtPg2t1MiodFBdyMK77Qbq1bun5G5-x2IpO6Mhabr71fay9d',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(body),
    );

    return response;
  }
}
