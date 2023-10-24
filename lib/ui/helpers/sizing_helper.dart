import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class SizingHelper {
  static final dateFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss');

  static double calculateSidebarWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return min(400, width * 0.3);
  }
}
