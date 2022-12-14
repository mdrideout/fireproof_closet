import 'dart:async';
import 'dart:ui' as ui;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fireproof_closet/src/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'cached_data.dart';

/// Loads from cloud or cache a given Firebase Storage [Reference] as Uint8List
///
/// This is essentially a different network downloading implementation of [FireproofImage]
/// tailored to Firebase Storage
@immutable
class FireproofImage extends ImageProvider<FireproofImage> {
  /// Creates an object that decodes a [Uint8List] buffer as an image.
  ///
  /// The arguments must not be null.
  const FireproofImage({
    required this.storageRef,
    this.cacheDuration = kDefaultDuration,
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
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
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

      // Evict from hot cache if we're breaking cache
      if (breakCache) {
        evict();
      }

      // First attempt to retrieve the image from cache (unless breakCache)
      final Uint8List? cachedBytes = (breakCache) ? null : await CachedData.getFromCache(storageRef);

      // If not in cache or expired, fetch the data from Firebase Storage
      final Uint8List? bytes = cachedBytes ?? await storageRef.getData(maxSize);

      if (bytes == null) {
        throw Exception('No data in cache and FireproofImage getData() returned null.');
      }

      if (bytes.lengthInBytes == 0) {
        throw Exception('FireproofImage is an empty file. 0 Bytes.');
      }

      // Cache the data if cachedBytes was null and cache == true
      if (cachedBytes == null && cache) {
        CachedData.saveToPersistentCache(storageRef: storageRef, bytes: bytes, cacheDuration: cacheDuration);
      }

      final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);

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

  // Required to utilize ImageProvider's hot memory caching system
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is FireproofImage && other.storageRef.fullPath == storageRef.fullPath && other.scale == scale;
  }

  // Required to utilize ImageProvider's hot memory caching system
  @override
  int get hashCode => Object.hash(storageRef.fullPath, scale);

  @override
  String toString() => '${objectRuntimeType(this, 'FireproofImage')}("${storageRef.toString()}", scale: $scale)';
}
