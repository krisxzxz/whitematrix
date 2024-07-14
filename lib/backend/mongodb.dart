import 'dart:developer';

import "package:fleett/backend/constant.dart";
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, driversCollection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    driversCollection = db.collection(DRIVERS_COLLECTION);
  }
}
