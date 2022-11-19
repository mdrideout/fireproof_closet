// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:isar/isar.dart';
//
// /// Cached Data
// /// The key ([storageRef]) and byte data [bytes] that will be saved to persistent cache.
// class CachedData {
//   /// Cache does not support storing the actual storageRef [Reference] type
//   @ignore
//   final Reference storageRef;
//
//   /// The actual byte data from Firebase Storage that will get saved to persistence
//   @ignore
//   final Uint8List bytes;
//
//   /// Compatible version of Uint8List
//   List<int> get bytesListInt => bytes.toList();
//
//   /// When the cache was created
//   final DateTime cacheCreated;
//
//   /// How long the cache should last from the created date before it is considered expired
//   @ignore
//   final Duration cacheDuration;
//
//   /// Compatible version of duration
//   final DateTime cacheExpires;
//
//   /// Isar ID: A 64-bit int hash generated from the storageRef
//   Id get id => _stringToIsarHashId(storageRef);
//
//   /// storageRefFullPath can be used to reconstruct a [Reference] that is not saved to the database
//   String get storageRefFullPath => storageRef.fullPath;
//
//   /// DO NOT USE THIS UNNAMED CONSTRUCTOR
//   ///
//   /// Use CachedData.cacheBytes() or CachedData.downloadAndCache() to ensure class properties
//   /// are properly generated and the data is properly cached
//   ///
//   /// Cache Data - Private internal constructor (cannot actually be private due to Isar code generation limitations)
//   ///
//   /// CachedData elements should only be created via the following methods that handle more actions
//   /// to actually download and / or store the bytes to cache.
//   CachedData({
//     required this.storageRef,
//     required this.bytes,
//     required this.cacheCreated,
//     required this.cacheExpires,
//     required this.cacheDuration,
//   });
//
//   /// Construct a complete CachedData item from the path
//   /// Creates a new [Reference] object based on the path.
//   /// Retrieves the rest of the data from Isar
//   /// // TODO: Is this even needed?
//   factory CachedData.fromFullPath(FirebaseStorage instance, String path) {
//     Reference storageRef = instance.ref(path);
//
//     // TODO: Get the rest of the data from Isar instead of using this filler
//     Uint8List bytes = Uint8List.fromList([10]);
//
//     // Return the constructed object
//     return CachedData(
//         storageRef: storageRef,
//         bytes: bytes,
//         cacheCreated: DateTime.now(),
//         cacheExpires: DateTime.now(),
//         cacheDuration: const Duration(minutes: 5));
//   }
// }
