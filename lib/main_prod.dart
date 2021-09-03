import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runZonedGuarded<Future<void>>(
    () async {
      runApp(
        ProviderScope(child: App()),
      );
    },
    (Object error, StackTrace stackTrace) => null,
    // FirebaseCrashlytics.instance.recordError(error, stackTrace),
  );
}
