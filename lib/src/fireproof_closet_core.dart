import 'package:hive_flutter/adapters.dart';

import 'cached_data.dart';

/// FireproofCloset - Singleton Implementation
/// Constructs a single _instance
/// Factory constructor always returns the same instance
/// Instance parameters can only be set if they are null, and will use default values from the Factory constructor
class FireproofCloset {
  bool? debugMode;
  Duration? defaultDuration;

  /// Always return a singleton instance
  static final FireproofCloset _instance = FireproofCloset._internal();

  /// Internal Constructor
  FireproofCloset._internal();

  /// Consumable Constructor
  factory FireproofCloset({bool debugMode = false, defaultDuration = const Duration(days: 365)}) {
    // Set null class parameters
    _instance.debugMode ??= debugMode;
    _instance.defaultDuration ??= defaultDuration;

    return _instance;
  }

  /// Isar database name
  static const String kDatabaseName = "fireproof_closet";

  /// Initialize the cache by opening the database with our data schemes (generated from @collection classes)
  Future<void> initialize() async {
    // Init Hive
    await Hive.initFlutter();

    // Register Type Adapter
    Hive.registerAdapter(CachedDataAdapter());

    // Open the database
    await Hive.openLazyBox<CachedData>(kDatabaseName);
    return;
  }

  /// Eternally callable functions
  static void clearCache() => CachedData.clearCache();
}
