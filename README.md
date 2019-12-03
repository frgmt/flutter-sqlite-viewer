# SQLite Viewer Widget

[![GitHub stars](https://img.shields.io/github/stars/frgmt/flutter-sqlite-viewer.svg?style=social)](https://github.com/frgmt/flutter-sqlite-viewer)
![GitHub last commit](https://img.shields.io/github/last-commit/frgmt/flutter-sqlite-viewer.svg)
[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/frgmt/flutter-sqlite-viewer)

This Flutter package provides a widget to display the contents of SQLite.

<img src="https://raw.githubusercontent.com/frgmt/flutter-sqlite-viewer/master/src/s1.gif" height="400" alt="Viewer">

# 💻 Installation
In the `dependencies:` section of your `pubspec.yaml`, add the following line:

[![Version](https://img.shields.io/pub/v/sqlite_viewer.svg)](https://pub.dartlang.org/packages/sqlite_viewer)

```yaml
dependencies:
  sqlite_viewer: <latest version>
```

# ❔ Usage

### Import this class

```dart
import 'package:sqlite_viewer/sqlite_viewer.dart';
```

### Just open the page
```dart
Navigator.push(context, MaterialPageRoute(builder: (_) => DatabaseList()))
```

# 👍 Contribution
1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

# 🧡 Thanks
- [sqflite](https://pub.dartlang.org/packages/sqflite)  [![GitHub stars](https://img.shields.io/github/stars/tekartik/sqflite.svg?style=social)](https://github.com/tekartik/sqflite)
- [json_table](https://pub.dartlang.org/packages/json_table)  [![GitHub stars](https://img.shields.io/github/stars/apgapg/json_table.svg?style=social)](https://github.com/apgapg/json_table)