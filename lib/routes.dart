import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/timeline/emoticon/details.dart';
import 'package:shop_app/screens/timeline/emoticon/emoticon.dart';
import 'package:shop_app/screens/timeline/fun_fact/funfact.dart';
import 'package:shop_app/screens/timeline/infografis_kesehatan/infografis_kesehatan.dart';
import 'package:shop_app/screens/timeline/jurnal/add_jurnal.dart';
import 'package:shop_app/screens/timeline/jurnal/jurnal_harian.dart';
import 'package:shop_app/screens/timeline/timeline.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  Timeline.routeName: (context) => Timeline(),
  JurnalHarian.routeName: (context) => JurnalHarian(),
  AddJurnal.routeName: (context) => AddJurnal(),
  Emoticon.routeName: (context) => Emoticon(),
  InfografisKesehatan.routeName: (context) => InfografisKesehatan(),
  FunFact.routeName: (context) => FunFact(),
  Details.routeName: (context) => Details(),
};
