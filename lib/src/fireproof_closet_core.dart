import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'cached_data.dart';
import 'constants.dart';

/// FireproofCloset - Singleton Implementation
/// Constructs a single _instance
/// Factory constructor always returns the same instance
/// Instance parameters can only be set if they are null, and will use default values from the Factory constructor
class FireproofCloset {
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

  /// Download And Cache
  /// Downloads the byte data from Firebase Storage
  /// and caches it locally for future use.
  ///
  /// [storageRef] is the Firebase Storage [Reference] object with the full relative path to the file
  ///
  /// Default cache duration: [kDefaultDuration]
  ///
  /// If [breakCache] is true, downloadAndCache will perform a fresh download even if the image is already in cache.
  /// to invalidate the [ImageCache] hot memory ImageProvider singleton cache.
  static Future<void> downloadAndCache(
    Reference storageRef, {
    BuildContext? context,
    Duration cacheDuration = kDefaultDuration,
    bool breakCache = false,
  }) =>
      CachedData.downloadAndCache(
        context: context,
        storageRef: storageRef,
        cacheDuration: cacheDuration,
        breakCache: breakCache,
      );

  /// Clear the cache
  static void clearCache() => CachedData.clearCache();

  /// Get the cache status
  static void cacheStatus() => CachedData.cacheStatus();

  /// Print everything in the cache
  static void printCacheItems() => CachedData.printCacheItems();
}
