import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/timeline/cerita_inspiratif/cerita_inspratif.dart';
import 'package:shop_app/screens/timeline/emoticon/emoticon.dart';
import 'package:shop_app/screens/timeline/fun_fact/funfact.dart';
import 'package:shop_app/screens/timeline/infografis_kesehatan/infografis_kesehatan.dart';
import 'package:shop_app/screens/timeline/jurnal/jurnal_harian.dart';

class Timeline extends StatefulWidget {
  static String routeName = "/timeline";

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/pyramid.jpg'),
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: -10,
                child: Container(
                  width: size.width * 0.93,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFFEA058),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        SizedBox(width: 7),
                        CircleAvatar(
                          child: Image.asset('assets/images/g2.png'),
                        ),
                        SizedBox(width: 7),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Selamat datang di timeline Anda!',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Text(
                                'Kami menyiapkan informasi yang menarik untukmu',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 220),
                    TimelineMenu(
                      size: size,
                      title: 'Fun Fact',
                      icon: FontAwesomeIcons.lightbulb,
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FunFact();
                        }));
                      },
                    ),
                    SizedBox(height: 20),
                    TimelineMenu(
                      size: size,
                      title: 'Emoticon',
                      icon: FontAwesomeIcons.smile,
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Emoticon();
                        }));
                      },
                    ),
                    SizedBox(height: 20),
                    TimelineMenu(
                      size: size,
                      title: 'Infografis Kesehatan',
                      icon: FontAwesomeIcons.industry,
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return InfografisKesehatan();
                        }));
                      },
                    ),
                    SizedBox(height: 20),
                    TimelineMenu(
                      size: size,
                      title: 'Cerita Inspiratif',
                      icon: FontAwesomeIcons.fileContract,
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CeritaInspiratif();
                        }));
                      },
                    ),
                    SizedBox(height: 20),
                    TimelineMenu(
                      size: size,
                      title: 'Jurnal Harian',
                      icon: FontAwesomeIcons.bookOpen,
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return JurnalHarian();
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.timeline),
    );
  }
}

class TimelineMenu extends StatelessWidget {
  const TimelineMenu({
    Key key,
    @required this.size,
    @required this.title,
    @required this.press,
    @required this.icon,
  }) : super(key: key);

  final Size size;
  final String title;
  final Function press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: size.width * 0.6,
        height: 90,
        decoration: BoxDecoration(
          color: Color(0xff1948AE),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              FaIcon(icon, color: Color(0xFFFDCC49)),
              SizedBox(width: 13),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
