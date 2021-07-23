import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
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
            press: () => {},
          ),
          ProfileMenu(
            text: "Undang teman",
            icon: "assets/icons/Invite.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Notifikasi",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Kalender",
            icon: "assets/icons/calender 2.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Pengaturan",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Bantuan",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Lembar Persetujuan",
            icon: "assets/icons/book.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Kaluar",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
