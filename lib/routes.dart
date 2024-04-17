import 'package:flutter/material.dart';
import 'package:hanap_app/pages/pages.dart';

abstract class Routes {
  static const home = '/';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => const HomePage(),
  };
}
