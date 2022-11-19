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
  Id get id => stringToHash(storageRefFullPath);

  /// The bytes stored
  final List<int> bytes;

  /// Cache created
  final DateTime cacheCreated;

  /// Cache expires
  final DateTime cacheExpires;

  /// Get Bytes consumable by the FireproofImage ImageProvider from cache
  /// Returns null if they are not in the cache
  static Future<Uint8List?> getFromCache(Reference storageRef) async {
    // Convert the storageRef full path to hash which is the basis for the id
    int id = storageRefToHash(storageRef);

    final Isar? isar = Isar.getInstance(FireproofCloset.kDatabaseName);
    if (isar == null) {
      throw ("Unable to get Isar instance: ${FireproofCloset.kDatabaseName}");
    }

    try {
      final CachedData? cachedData = await isar.cachedDatas.get(id);

      if (cachedData == null) {
        debugPrint("Not found in cache: ${storageRef.fullPath}, Hash: $id");
        return null;
      }
      debugPrint("Found in cache: ${storageRef.fullPath}, Hash: $id");

      // If we are past the expiration date
      DateTime now = DateTime.now();
      if (now.isAfter(cachedData.cacheExpires)) {
        debugPrint("Cache expired at ${cachedData.cacheExpires} and it is now $now, returning null.");
        return null;
      }

      // Return as Uint8List
      return Uint8List.fromList(cachedData.bytes);
    } catch (e) {
      debugPrint("getFromCache() failed to read to Isar database.");
      rethrow;
    }
  }

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
        int id = await isar.cachedDatas.put(cachedData);
        debugPrint("cacheBytes() saved to Isar. id: $id");
      });
    } catch (e) {
      debugPrint(
          "cacheBytes() failed to write to Isar database.\nPath: ${storageRef.fullPath},\nUint8List size: ${bytes.lengthInBytes}\nList<int> size: ${bytes.toList().length}");
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
