import 'dart:collection';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/core/presentation/providers/providers.dart';
import 'package:shop_app/features/events/data/models/app_event.dart';
import 'package:shop_app/features/events/data/services/event_firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/presentation/res/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/timeline/emoticon/details.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/presentation/res/sizes.dart';

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

class Emoticon extends StatefulWidget {
  static String routeName = "/emoticon";

  @override
  _EmoticonState createState() => _EmoticonState();
}

class _EmoticonState extends State<Emoticon> {
  LinkedHashMap<DateTime, List<AppEvent>> _groupedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  @override
  void didChangeDependencies() {
    context.read(pnProvider).init();
    super.didChangeDependencies();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _groupEvents(List<AppEvent> events) {
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    events.forEach((event) {
      DateTime date =
          DateTime.utc(event.date.year, event.date.month, event.date.day, 12);
      if (_groupedEvents[date] == null) _groupedEvents[date] = [];
      _groupedEvents[date].add(event);
    });
  }

  List<dynamic> _getEventsForDay(DateTime date) {
    return _groupedEvents[date] ?? [];
  }

  List emotions = [
    ['super.svg', Colors.orange],
    ['smile.svg', Colors.red],
    ['no_exp.svg', Colors.blue],
    ['sad.svg', Colors.green],
    ['cry.svg', Colors.purple],
  ];

  checkEmotion(String emotion) {
    String data = 'null';
    int i = 0;
    emotions.forEach((element) {
      if (emotion == emotions[i][0]) {
        data = 'assets/icons/$emotion';
      }

      i++;
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.ad),
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Details();
            })),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: eventDBS.streamQueryList(args: [
            QueryArgsV2(
              "user_id",
            ),
          ]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final events = snapshot.data;
              _groupEvents(events);
              DateTime selectedDate = _selectedDay;
              final _selectedEvents = _groupedEvents[selectedDate] ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(8.0),
                    child: TableCalendar(
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(day, _selectedDay),
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      eventLoader: _getEventsForDay,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      weekendDays: [6],
                      headerStyle: HeaderStyle(
                        decoration: BoxDecoration(
                          color: Color(0xff1948AE),
                        ),
                        headerMargin: const EdgeInsets.only(bottom: 8.0),
                        titleTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                        formatButtonDecoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              BorderRadius.circular(AppSizes.borderRadius),
                        ),
                        formatButtonTextStyle: TextStyle(color: Colors.white),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ),
                      calendarStyle: CalendarStyle(),
                      calendarBuilders: CalendarBuilders(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Text(
                      DateFormat('EEEE, dd MMMM, yyyy').format(selectedDate),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _selectedEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      AppEvent event = _selectedEvents[index];
                      return ListTile(
                        title: checkEmotion(event.title) != 'null'
                            ? SvgPicture.asset(
                                'assets/icons/' + event.title,
                                height: 150,
                                alignment: Alignment.centerLeft,
                              )
                            : Text(
                                event.title,
                              ),
                        // subtitle: Text(
                        //   DateFormat("EEEE, dd MMMM, yyyy").format(event.date),
                        // ),
                        onTap: () => checkEmotion(event.title) == 'null'
                            ? Navigator.pushNamed(context, AppRoutes.viewEvent,
                                arguments: event)
                            : null,
                        trailing: checkEmotion(event.title) != 'null'
                            ? SizedBox()
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.editEvent,
                                  arguments: event,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              );
            }
            return Center(
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.44),
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          // print(_selectedDay);
          Navigator.pushNamed(context, AppRoutes.addEvent,
              arguments: _selectedDay);
          print('Touched!');
        },
      ),
    );
  }
}
