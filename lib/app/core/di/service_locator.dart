import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:univa_task/app/core/client/http_client.dart';
import 'package:univa_task/data/local/task_service.dart';
import 'package:univa_task/data/local/task_service_impl.dart';
import 'package:univa_task/data/remote/auth_service.dart';
import 'package:univa_task/data/remote/auth_service_impl.dart';
import 'package:univa_task/data/remote/task_service.dart';
import 'package:univa_task/data/remote/task_service_impl.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  sl.registerSingleton<Dio>(Dio(opts));
  sl.registerSingleton<CustomHttpClient>(CustomHttpClient(sl.get<Dio>()));
  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl(sl.get<CustomHttpClient>()));
  sl.registerLazySingleton<TaskService>(() => TaskServiceImpl(sl.get<CustomHttpClient>()));
  sl.registerLazySingleton<TaskCacheService>(() => TaskCacheServiceImpl());
}

Duration timeout = const Duration(seconds: 120);
BaseOptions opts = BaseOptions(
  responseType: ResponseType.json,
  connectTimeout: timeout,
  receiveTimeout: timeout,
  contentType: 'application/json',
);