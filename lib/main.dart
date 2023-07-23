import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app/app/app.dart';
import 'package:food_app/app/di.dart';
import 'package:food_app/firebase_options.dart';
import 'package:food_app/presentation/resources/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.getInitialMessage();
  LocalNotificationService().initNotification();

  await initAppModule();

  runApp(MyApp());
}
