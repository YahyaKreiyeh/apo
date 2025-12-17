import 'dart:async';
import 'package:flutter/widgets.dart';

/// Broadcasts locale changes so widgets/cubits can react by reloading data.
class LocaleChangeNotifier {
  final _controller = StreamController<Locale>.broadcast();

  Stream<Locale> get stream => _controller.stream;

  void notify(Locale locale) => _controller.add(locale);

  void dispose() => _controller.close();
}
