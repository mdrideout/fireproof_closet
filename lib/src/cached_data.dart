import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'fireproof_closet_core.dart';
import 'util.dart';

part 'cached_data.g.dart';

/// Data saved in a format compatible with isar database
@collection
class CachedData {
  CachedData(this.storageRefFullPath, this.bytes, this.cacheCreated, this.cacheExpires);

  /// The full path of the [Reference] storage ref (because the [Reference] object is not compatible with isar)
  final String storageRefFullPath;

  /// The Isar Item ID
  Id get id => stringToIsarHash(storageRefFullPath);

  /// The bytes stored
  final List<int> bytes;

  /// Cache created
  final DateTime cacheCreated;

  /// Cache expires
  final DateTime cacheExpires;

  /// Get Bytes consumable by the FireproofImage ImageProvider from cache
  /// Returns null if they are not in the cache
  // static Future<Uint8List?> bytesFromCache(Reference storageRef) {}

  /// Cache Now
  /// Caches an already downloaded Firebase Storage reference
  /// and its bytes for future use.
  static Future<void> cacheBytes({
    required Reference storageRef,
    required Uint8List bytes,
    Duration cacheDuration = const Duration(minutes: 5),
  }) async {
    // Create cacheCreated datetime
    DateTime now = DateTime.now();

    // Create an expiration from the duration
    DateTime expires = now.add(cacheDuration);

    // Construct the entire cache object
    CachedData cachedData = CachedData(storageRef.fullPath, bytes, now, expires);

    final Isar? isar = Isar.getInstance(FireproofCloset.kDatabaseName);
    if (isar == null) {
      throw ("Unable to get Isar instance: ${FireproofCloset.kDatabaseName}");
    }

    try {
      await isar.writeTxn(() async {
        await isar.cachedDatas.put(cachedData);
      });

      debugPrint("cacheBytes() saved to Isar");
    } catch (e) {
      debugPrint("cacheBytes() failed to write to Isar database.");
      rethrow;
    }

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
    final Isar? isar = Isar.getInstance(FireproofCloset.kDatabaseName);
    if (isar == null) {
      throw ("Unable to get Isar instance: ${FireproofCloset.kDatabaseName}");
    }

    // Download the image from Firebase Storage based on the reference
    // TODO:

    // Convert to bytes for caching
    List<int> bytes = Uint8List(10).toList();

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
}
