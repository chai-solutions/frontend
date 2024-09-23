import 'dart:io';

import 'package:talker_flutter/talker_flutter.dart';

final logger = Talker(
  logger: TalkerLogger(
    settings: TalkerLoggerSettings(
      // Colors do not work on iOS for the time being.
      // Figure this out later.
      enableColors: !Platform.isIOS,
    ),
  ),
);
