# Fireproof Closet
Cache your Firebase Storage data to the Fireproof Closet. When you use the `FireproofImage`
image provider, your image will be loaded instantly from the cache, or it will be downloaded and cached for future display.

### Persistence
The Fireproof Closet cache is persistent, so users can close and re-open the app
and not have to wait for images to download again.

### How it Works
Fireproof Closet is a combination of a custom ImageProvider called `FireproofImage` which
is capable of acquiring and caching images from Firebase Storage, and the [Hive](https://pub.dev/packages/hive)
database to store and manage the data in persistence.

### Cross Platform
- [Hive](https://pub.dev/packages/hive) is a cross-platform database that has fast speeds on all Flutter platforms.
- The rest of the Fireproof Closet system is written in Dart which is inherently cross-platform

### Speed Example
Loading images from cache vs downloading on iOS.

First cache read after the database is initialized may be slower. Cache reads below are for subsequent reads. 

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

- Isar loads large images approximately 3x faster (7 MB in ~20ms) but the difference is negligible on smaller images under 1 MB.
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
  FireproofCloset fireproofCloset = FireproofCloset(
    debugMode: true, // Default is false
    defaultDuration: const Duration(days: 7), // Default is 365 days
  );
  await fireproofCloset.initialize();
  
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
            .child("full/path/to/image.jpg"), // The full relative path to the image
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
for(var file in files) {
  FireproofCloset.downloadAndCache(file);
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
