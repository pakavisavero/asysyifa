import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bantuan extends StatefulWidget {
  @override
  _BantuanState createState() => _BantuanState();
}

class _BantuanState extends State<Bantuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            print('fsff');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Bantuan",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.quiz,
                  color: Colors.blue.shade900,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Pusat Bantuan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 40,
              thickness: 1,
            ),
            Row(
              children: [
                Icon(
                  Icons.people_rounded,
                  color: Colors.blue.shade900,
                ),
                SizedBox(
                  height: 20,
                  width: 10,
                ),
                Text(
                  "Hubungi Kami",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 40,
              thickness: 1,
            ),
            Row(
              children: [
                Icon(
                  Icons.privacy_tip_sharp,
                  color: Colors.blue.shade900,
                ),
                SizedBox(
                  height: 20,
                  width: 10,
                ),
                Text(
                  "Ketentuan dan Kebijakan Privasi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 40,
              thickness: 1,
            ),
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.blue.shade900,
                ),
                SizedBox(
                  height: 20,
                  width: 10,
                ),
                Text(
                  "Info Aplikasi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
