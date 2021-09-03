import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:shop_app/core/data/res/data_constants.dart';
import 'package:shop_app/features/events/data/models/app_event.dart';

final eventDBS = DatabaseService<AppEvent>(
  AppDBConstants.eventsCollection,
  fromDS: (id, data) => AppEvent.fromDS(id, data),
  toMap: (event) => event.toMap(),
);
