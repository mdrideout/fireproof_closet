import 'package:isar/isar.dart';

import 'cached_data.dart';

class FireproofCloset {
  /// Isar database name
  static const String kDatabaseName = "fireproof_closet";

  /// Initialize the cache by opening the database with our data schemes (generated from @collection classes)
  static Future<void> initialize() async {
    await Isar.open([CachedDataSchema], name: kDatabaseName);
    return;
  }
}
