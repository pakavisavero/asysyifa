import 'package:flutter/material.dart';
import 'package:shop_app/components/Bantuan.dart';
import 'package:shop_app/components/Invite.dart';
import 'package:shop_app/components/lembarpersetujuan.dart';
import 'package:shop_app/components/profil.dart';
import 'package:shop_app/components/setting.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/services/google_auth.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  Future<bool> _onSignOut(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => _signOut(context),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<void> _signOut(BuildContext context) async {
    await signOutWithGoogle().then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.routeName, (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
              text: "Profile",
              icon: "assets/icons/User Icon.svg",
              press: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Profil();
                    }))
                  }),
          ProfileMenu(
              text: "Undang teman",
              icon: "assets/icons/Invite.svg",
              press: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Invite();
                    }))
                  }),
          ProfileMenu(
              text: "Pengaturan",
              icon: "assets/icons/Settings.svg",
              press: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Setting();
                    }))
                  }),
          ProfileMenu(
              text: "Bantuan",
              icon: "assets/icons/Question mark.svg",
              press: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Bantuan();
                    }))
                  }),
          ProfileMenu(
              text: "Lembar Persetujuan",
              icon: "assets/icons/book.svg",
              press: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LembarPersetujuan();
                    }))
                  }),
          ProfileMenu(
            text: "Kaluar",
            icon: "assets/icons/Log out.svg",
            press: () async => await _onSignOut(context),
          ),
        ],
      ),
    );
  }
}
