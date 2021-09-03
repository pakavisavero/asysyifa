import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/core/presentation/res/constants.dart';
import 'package:shop_app/core/presentation/res/routes.dart';
import 'package:shop_app/core/presentation/res/themes.dart';
import 'package:shop_app/generated/l10n.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';

import 'core/presentation/providers/providers.dart';
import 'core/presentation/res/analytics.dart';
import 'core/presentation/res/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      overrides: [
        configProvider.overrideWithProvider(
          Provider(
            (ref) => AppConfig(
              appTitle: AppConstants.appNameDev,
              buildFlavor: AppFlavor.dev,
            ),
          ),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppThemes.context = context;
    return Consumer(builder: (context, watch, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: watch(analyticsProvider),
            nameExtractor: analyticsNameExtractor,
          )
        ],
        onGenerateRoute: AppRoutes.onGenerateRoute,
        title: 'As-Syifa',
        theme: theme(),

        // home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        initialRoute: SplashScreen.routeName,
        routes: routes,
      );
    });
  }
}
