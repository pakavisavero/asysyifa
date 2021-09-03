import 'package:firebase_analytics/observer.dart';
import 'package:shop_app/core/presentation/res/analytics.dart';
import 'package:shop_app/core/presentation/res/routes.dart';
import 'package:shop_app/features/auth/presentation/pages/home.dart';
import 'package:shop_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/presentation/providers/providers.dart';
import 'core/presentation/res/themes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppThemes.context = context;
    return Consumer(builder: (context, watch, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: watch(configProvider).appTitle,
        theme: AppThemes.defaultTheme,
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
        home: AuthHomePage(),
      );
    });
  }
}
