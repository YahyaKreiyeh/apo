import 'package:apo/apo.dart';
import 'package:apo/core/di/dependency_injection.dart';
import 'package:apo/core/helpers/secure_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final authToken = await SecureStorageHelper.getAuthToken();
  final isAuthenticated = authToken.isNotEmpty;
  runApp(Apo(isAuthenticated: isAuthenticated));
}
