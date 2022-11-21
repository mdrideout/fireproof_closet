import 'package:firebase_storage/firebase_storage.dart';
import 'package:fireproof_closet/fireproof_closet.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'cached_data.g.dart';

/// Data saved in a format compatible with isar database
@HiveType(typeId: 169)
class CachedData {
  CachedData(this.storageRefFullPath, this.bytes, this.cacheCreated, this.cacheExpires);

  /// The full path of the [Reference] storage item
  @HiveField(0)
  final String storageRefFullPath;

  /// The bytes stored
  @HiveField(1)
  final Uint8List bytes;

  /// Cache created
  @HiveField(2)
  final DateTime cacheCreated;

  /// Cache expires
  @HiveField(3)
  final DateTime cacheExpires;

  @override
  String toString() {
    return "CachedData: fullPath: $storageRefFullPath, size: ${(bytes.lengthInBytes / 1000).toStringAsFixed(2)} kb, created: $cacheCreated, expires: $cacheExpires";
  }

  /// Get Bytes consumable by the FireproofImage ImageProvider from cache
  /// Returns null if they are not in the cache
  static Future<Uint8List?> getFromCache(Reference storageRef) async {
    bool debugMode = FireproofCloset().debugMode ?? false;
    LazyBox<CachedData> box = Hive.lazyBox<CachedData>(FireproofCloset.kDatabaseName);

    final CachedData? cachedData = await box.get(storageRef.fullPath);

    if (cachedData == null) {
      if (debugMode) debugPrint("Not found in cache: ${storageRef.fullPath}");
      return null;
    }
    if (debugMode) debugPrint("Found in cache: ${storageRef.fullPath}");

    // If we are past the expiration date
    DateTime now = DateTime.now();
    if (now.isAfter(cachedData.cacheExpires)) {
      if (debugMode) debugPrint("Cache expired at ${cachedData.cacheExpires} and it is now $now, returning null.");
      return null;
    }

    // Return as Uint8List
    return cachedData.bytes;
  }

  /// Cache Now
  /// Caches an already downloaded Firebase Storage reference
  /// and its bytes for future use.
  static Future<void> cacheBytes({
    required Reference storageRef,
    required Uint8List bytes,
    Duration cacheDuration = const Duration(minutes: 5),
  }) async {
    bool debugMode = FireproofCloset().debugMode ?? false;
    LazyBox<CachedData> box = Hive.lazyBox<CachedData>(FireproofCloset.kDatabaseName);

    // Create cacheCreated datetime
    DateTime now = DateTime.now();

    // Create an expiration from the duration
    DateTime expires = now.add(cacheDuration);

    // Construct the entire cache object
    CachedData cachedData = CachedData(storageRef.fullPath, bytes, now, expires);

    // Write the data
    await box.put(storageRef.fullPath, cachedData);

    if (debugMode) debugPrint("Cached: ${cachedData.toString()}");

    return;
  }

  /// Download And Cache
  /// Downloads the byte data from Firebase Storage
  /// and caches it locally for future use.
  ///
  /// The default [duration] is 5 minutes.
  static Future<CachedData> downloadAndCache({
    required Reference storageRef,
    Duration cacheDuration = const Duration(minutes: 5),
  }) async {
    LazyBox<CachedData> box = Hive.lazyBox<CachedData>(FireproofCloset.kDatabaseName);

    // Download the image from Firebase Storage based on the reference
    // TODO:

    // Convert to bytes for caching
    Uint8List bytes = Uint8List(10);

    // Create cacheCreated datetime
    DateTime now = DateTime.now();

    // Create an expiration from the duration
    DateTime expires = now.add(cacheDuration);

    // Construct the entire cache object
    CachedData cachedData = CachedData(storageRef.fullPath, bytes, now, expires);

    // Save it to locale persistent cache
    // TODO:

    // Return it to the UI
    return cachedData;
  }

  /// Clear Cache
  /// Deletes all cached items from the cache
  static Future<void> clearCache() async {
    bool debugMode = FireproofCloset().debugMode ?? false;
    LazyBox<CachedData> box = Hive.lazyBox<CachedData>(FireproofCloset.kDatabaseName);
    await box.deleteAll(box.keys);
    if (debugMode) debugPrint("Cache deleted");
    return;
  }

  /// Cache Status
  /// Details about the cache
  static Future<void> cacheStatus() async {
    LazyBox<CachedData> box = Hive.lazyBox<CachedData>(FireproofCloset.kDatabaseName);
    var keys = box.keys;

    debugPrint("Number of cached items: ${keys.length}");

    List<Future<CachedData?>> futures = keys.map((item) {
      return box.get(item);
    }).toList();

    List<CachedData?> items = await Future.wait<CachedData?>(futures);

    int totalCacheFileSize = 0;

    for (var item in items) {
      if (item != null) {
        totalCacheFileSize += item.bytes.lengthInBytes;
      }
    }

    debugPrint("Total cache size ${(totalCacheFileSize / 1000 / 1000).toStringAsFixed(4)} MB");
  }

  /// Print Cache Items
  /// Print all of the items currently in cache
  static void printCacheItems() async {
    LazyBox<CachedData> box = Hive.lazyBox<CachedData>(FireproofCloset.kDatabaseName);
    var keys = box.keys;

    List<Future<CachedData?>> futures = keys.map((item) {
      return box.get(item);
    }).toList();

    List<CachedData?> items = await Future.wait<CachedData?>(futures);

    int count = 0;

    debugPrint("=====================\nAll cached items:");
    for (var item in items) {
      if (item != null) {
        debugPrint("$count ${item.toString()}");
        count++;
      }
    }
    debugPrint("End of cached items.\n=====================");
  }
}
