import 'package:flutter_antonx_boilerplate/core/config/config.dart';
import 'package:flutter_antonx_boilerplate/core/enums/env.dart';
import 'package:get_it/get_it.dart';

import 'core/services/api_services.dart';
import 'core/services/auth_service.dart';
import 'core/services/database_service.dart';
import 'core/services/file_picker_service.dart';
import 'core/services/notifications_service.dart';
import 'core/services/local_storage_service.dart';

GetIt locator = GetIt.instance;

setupLocator(Env env) async {
  locator.registerSingleton(Config(env));
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton(NotificationsService());
  locator.registerSingleton<ApiServices>(ApiServices());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerLazySingleton(() => FilePickerService());
}
