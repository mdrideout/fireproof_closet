import 'package:hive_flutter/adapters.dart';

import 'cached_data.dart';

class FireproofCloset {
  /// Isar database name
  static const String kDatabaseName = "fireproof_closet";

  /// Initialize the cache by opening the database with our data schemes (generated from @collection classes)
  static Future<void> initialize() async {
    // Init Hive
    await Hive.initFlutter();

    // Register Type Adapter
    Hive.registerAdapter(CachedDataAdapter());

    // Open the database
    await Hive.openLazyBox<CachedData>(kDatabaseName);
    return;
  }
}
