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

# Implementation
**Initialize Fireproof Closet at app startup**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase: Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Storage Image Caching
  await FireproofCloset.initialize();

  ...
}
```

Example showing firebase storage reference in FireproofImage image provider.
```dart

Example here.

```

Example showing a loop precaching all images in a container
```dart

Example here.

```

---

# Limitations
- Max single image storage size is 16MB