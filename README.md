# Fireproof Closet
Cache your Firebase Storage data to the Fireproof Closet. When you use the `FireproofImage`
image provider, your image will be loaded instantly from the cache, or it will be downloaded and cached for future display.

### Persistence
The Fireproof Closet cache is persistent, so users can close and re-open the app
and not have to wait for images to download again.

### How it Works
Fireproof Closet is a combination of a custom ImageProvider called `FireproofImage` which
is capable of acquiring and caching images from Firebase Storage, and the [Isar](https://github.com/isar/isar)
database to store and manage the data in persistence.

### Cross Platform
- [Isar](https://github.com/isar/isar) is a Rust-based database that has blazingly fast speeds on all Flutter platforms.
- The rest of the Fireproof Closet system is written in Dart which is inherently cross-platform

### Speed Example
Loading images from cache vs downloading on iOS.

First cache read after the database is initialized may be slower. Cache reads below are for subsequent reads. 

#### 70 KB Image
- **Not found in cache, downloading from Firebase Storage**
  - Cache stage duration: ~45ms
  - Firebase storage stage duration: 338ms


- **Loaded from cache**
    - Cache stage duration: ~11ms
    - Firebase storage stage duration: 0ms

#### 7 MB Image
- **Not found in cache, downloading from Firebase Storage**
    - Cache stage duration: ~45ms
    - Firebase storage stage duration: 913ms


- **Loaded from cache**
    - Cache stage duration: ~60ms
    - Firebase storage stage duration: 0ms

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

Example showing firebase storage reference in FireproofImage image provider.
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
            .child("bucket-name/file-name.jpeg"), // The full relative path to the image
      ),
    );
  }
}
```

Example showing a loop precaching all images in a container
```dart

// Example here.

```

---

# Limitations
The same [limitations for Isar](https://isar.dev/limitations.html) exist for this package.

- Max single image storage size is 16MB