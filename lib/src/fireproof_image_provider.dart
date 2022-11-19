import 'dart:async';
import 'dart:ui' as ui;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'cached_data.dart';

/// Loads from cloud or cache a given Firebase Storage [Reference] as Uint8List
///
/// This is essentially a different network downloading implementation of [FireproofImage]
/// tailored to Firebase Storage
///
/// * [Image.fireproof] for a shorthand of an [Image] widget backed by [FireproofImage] ImageProvider
/// // TODO: Create Image.fireproof named constructor extension on the Image class.
@immutable
class FireproofImage extends ImageProvider<FireproofImage> {
  /// Creates an object that decodes a [Uint8List] buffer as an image.
  ///
  /// The arguments must not be null.
  const FireproofImage({
    required this.storageRef,
    this.cacheDuration = const Duration(minutes: 5),
    this.cache = true,
    this.breakCache = false,
    this.scale = 1.0,
    this.maxSize = 104857600,
  });

  /// Firebase Storage [Reference]
  final Reference storageRef;

  /// Max size of getData() item before an exception is thrown (defaults to 104.9MB)
  final int maxSize;

  /// Cache Duration (will fetch from the Firebase Storage if duration is exceeded).
  /// Defaults to 5 minutes.
  final Duration cacheDuration;

  /// Whether to cache the image when it is loaded
  final bool cache;

  /// Break Cache to force a fresh download
  final bool breakCache;

  /// The scale to place in the [ImageInfo] object of the image.
  ///
  /// See also:
  ///
  ///  * [ImageInfo.scale], which gives more information on how this scale is
  ///    applied.
  final double scale;

  @override
  Future<FireproofImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<FireproofImage>(this);
  }

  @override
  ImageStreamCompleter loadBuffer(FireproofImage key, DecoderBufferCallback decode) {
    // Ownership of this controller is handed off to [_loadAsync]; it is that
    // method's responsibility to close the controller's stream when the image
    // has been loaded or an error is thrown.
    final StreamController<ImageChunkEvent> chunkEvents = StreamController<ImageChunkEvent>();

    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      debugLabel: "FireproofImage(${storageRef.toString()})",
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<FireproofImage>('Image provider', this),
        DiagnosticsProperty<FireproofImage>('Image key', key),
      ],
    );
  }

  Future<ui.Codec> _loadAsync(
    FireproofImage key,
    DecoderBufferCallback decode,
  ) async {
    try {
      assert(key == this);
      // For debug stats
      late DateTime debugCacheStart;
      late DateTime debugCacheEnd;
      late DateTime debugFirebaseStorageStart;
      late DateTime debugFirebaseStorageEnd;

      // TODO: First check if the image is in cache and if it's not expired
      debugCacheStart = DateTime.now();
      final Uint8List? cachedBytes = await CachedData.getFromCache(storageRef);
      debugCacheEnd = DateTime.now();

      // TODO: If not in cache or expired, fetch the data from Firebase Storage AND cache the data with isar

      // Fetch the data from Firebase Storage
      debugFirebaseStorageStart = DateTime.now();
      final Uint8List? bytes = cachedBytes ?? await storageRef.getData(maxSize);
      debugFirebaseStorageEnd = DateTime.now();

      if (bytes == null) {
        throw Exception('FireproofImage getData() returned null.');
      }

      if (bytes.lengthInBytes == 0) {
        throw Exception('FireproofImage is an empty file. 0 Bytes returned.');
      }

      if (cache) {
        CachedData.cacheBytes(storageRef: storageRef, bytes: bytes);
      }

      final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);

      debugPrint(
          "Cache stage duration (null? ${(cachedBytes == null)}): ${debugCacheEnd.difference(debugCacheStart).inMilliseconds}ms");
      debugPrint(
          "Firebase storage stage duration (null? ${!(cachedBytes == null)}): ${debugFirebaseStorageEnd.difference(debugFirebaseStorageStart).inMilliseconds}ms");
      return decode(buffer);
    } catch (e) {
      // Depending on where the exception was thrown, the image cache may not
      // have had a chance to track the key in the cache at all.
      // Schedule a microtask to give the cache a chance to add the key.
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    }
  }

  @override
  String toString() => '${objectRuntimeType(this, 'FireproofImage')}("${storageRef.toString()}", scale: $scale)';
}
