import 'package:apo/core/networking/dio_factory.dart';
import 'package:apo/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:apo/features/authentication/data/services/authentication_api_service.dart';
import 'package:apo/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:apo/features/authentication/domain/usecases/login_usecase.dart';
import 'package:apo/features/authentication/presentation/cubits/login_cubit.dart';
import 'package:apo/features/home/data/repositories/products_repository_impl.dart';
import 'package:apo/features/home/data/services/products_api_service.dart';
import 'package:apo/features/home/domain/repositories/products_repository.dart';
import 'package:apo/features/home/domain/usecases/get_product_details_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_products_usecase.dart';
import 'package:apo/features/home/presentation/cubits/product_details_cubit.dart';
import 'package:apo/features/home/presentation/cubits/products_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  const secureStorage = FlutterSecureStorage();
  getIt.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);

  getIt.registerLazySingleton<Dio>(() => DioFactory.create());

  getIt.registerFactory(() => LoginCubit(getIt<LoginUseCase>()));
  getIt.registerFactory(() => ProductsCubit(getIt<GetProductsUseCase>()));
  getIt.registerFactoryParam<ProductDetailsCubit, int, void>(
    (productId, _) => ProductDetailsCubit(
      getIt<GetProductDetailsUseCase>(),
      productId: productId,
    ),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthenticationRepository>()),
  );
  getIt.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(getIt<ProductsRepository>()),
  );
  getIt.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(getIt<ProductsRepository>()),
  );

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(getIt<AuthenticationApiService>()),
  );
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(getIt<ProductsApiService>()),
  );

  getIt.registerLazySingleton<AuthenticationApiService>(
    () => AuthenticationApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ProductsApiService>(
    () => ProductsApiService(getIt<Dio>()),
  );
}
