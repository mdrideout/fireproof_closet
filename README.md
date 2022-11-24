# Fireproof Closet
Cache your Firebase Storage data to the Fireproof Closet. When you use the `FireproofImage`
image provider, your image will be loaded instantly from the cache, or it will be downloaded and cached for future display.

### Persistence
The Fireproof Closet cache is persistent, so users can close and re-open the app
and not have to wait for images to download again.

### In-Memory Speed
Images displayed with the FireproofImage() provider are kept in the hot memory ImageCache for instant loading.


### How it Works
Fireproof Closet is a combination of a custom ImageProvider called `FireproofImage` which
is capable of acquiring and caching images from Firebase Storage, and the [Hive](https://pub.dev/packages/hive)
database to store and manage the data in persistence. Images are loaded into the hot memory ImageCache when displayed with
the FireproofImage() provider, or ahead of time with pre-caching by using `FireproofCloset.downloadAndCache(context, storageRef);`.

### Cross Platform
- [Hive](https://pub.dev/packages/hive) is a cross-platform database that has fast speeds on all Flutter platforms.
- The rest of the Fireproof Closet system is written in Dart which is inherently cross-platform

### Speed Example
Loading images from persistent cache vs downloading from Firebase Storage on iOS.

First cache read after the database is initialized may be slower. Cache reads below are for subsequent reads.

_After reading from persistent cache, the image is stored in hot memory for instant loading. The following reflects speed improvements
compared to Firebase Storage downloading._

#### 70 KB Image
- **Not found in cache, downloading from Firebase Storage**
  - Cache stage duration: ~45ms
  - Firebase storage stage duration: 338ms


- **Loaded from cache**
    - Cache stage duration: ~12ms
    - Firebase storage stage duration: 0ms

#### 7 MB Image
- **Not found in cache, downloading from Firebase Storage**
    - Cache stage duration: ~45ms
    - Firebase storage stage duration: 913ms


- **Loaded from cache**
    - Cache stage duration: ~60ms
    - Firebase storage stage duration: 0ms

### Future Changes
In the future, Hive will be replaced with [Isar](https://pub.dev/packages/isar) which is a cross-platform database that uses
native code for each platform. However, [Web does not currently work properly](https://github.com/isar/isar/issues/686).

- Isar loads large images into memory from persistent storage approximately 3x faster (7 MB in ~20ms) but the difference is negligible on smaller images under 1 MB.
- This upgrade should be a non-breaking change since the API will remain identical, but with a higher speed database behind the scenes.

# Implementation
**Initialize Fireproof Closet at app startup**
```dart
import 'package:fireproof_closet/fireproof_closet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase: Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Storage Image Caching
  await FireproofCloset.initialize();
  
  // ...
}
```

- **debugMode**: In development builds, will log performance data and activity of caching to the console.
- **defaultDuration**: How long all caches should persist before expiring, by default

## Display An Image

FireproofImage is an image provider that can be provided to an Image widget, or
any widget that takes an image provider.
```dart
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fireproof_closet/fireproof_closet.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: FireproofImage(
        storageRef: FirebaseStorage.instance
                .ref()
                .child("full/path/to/image.jpg"), // Required, the full relative path to the image in Firebase Storage
        breakCache: true, // Optional, defaults to false, will force a fresh download and evict the image from memory
        cacheDuration: const Duration(minutes: 5), // Optional, defaults to 365 days
        cache: false, // Optional, defaults to true. If false, will not save the image to persistent cache
      ),
    );
  }
}
```

## Precache Images (or files)

Download images before they need to be shown to improve the user experience.

_(This also works with any file, and not just images.)_

This is helpful for long scrolling `ListView.builder()` type widgets, where you do not 
want to wait for each image to download from Firebase Storage as it is scrolled into view. Load
it from the cache in milliseconds instead.

Optionally, `await` these downloads.
```dart
FireproofCloset.downloadAndCache(FirebaseStorage.instance.ref().child("full/path/to/image.jpg"));
```

**Precache a ton of images at a time**
```dart
// A list of Firebase Storage References
List<Reference> files = [
  FirebaseStorage.instance.ref().child("full/path/to/image.jpg"),
  FirebaseStorage.instance.ref().child("full/path/to/image1.jpg"),
  FirebaseStorage.instance.ref().child("full/path/to/image2.jpg"),
];

// Cache them all at once in a loop
// If context is null, images will only be downloaded to persistence and not loaded into hot memory [ImageCache]
for (var file in files) {
  FireproofCloset.downloadAndCache(storageRef, context: context);
}
```

---

# Helpful Utilities

#### Clear the cache
Delete all items from the cache

```dart
FireproofCloset.clearCache();
```

---

#### Print Cache Status

```dart
FireproofCloset.cacheStatus();
```

*Example Output*
```bash
flutter: Number of cached items: 1
flutter: Total cache size 0.0689 MB
```

---

#### Print Cache Items

```dart
FireproofCloset.printCacheItems();
```

*Example Output*
```bash
flutter: =====================
flutter: All cached items:
flutter: 0 CachedData: fullPath: full/path/to/image.jpg, size: 68.87 kb, created: 2022-11-20 20:19:04.624, expires: 2022-11-20 20:24:04.624
flutter: End of cached items.
flutter: =====================
```
