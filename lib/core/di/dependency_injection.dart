import 'package:apo/core/constants/secure_storage_keys.dart';
import 'package:apo/core/extensions/null_or_empty_extensions.dart';
import 'package:apo/core/networking/dio_factory.dart';
import 'package:apo/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:apo/features/authentication/data/services/authentication_api_service.dart';
import 'package:apo/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:apo/features/authentication/domain/usecases/login_usecase.dart';
import 'package:apo/features/authentication/presentation/cubits/login_cubit.dart';
import 'package:apo/features/checkout/checkout_type.dart';
import 'package:apo/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:apo/features/checkout/data/services/checkout_api_service.dart';
import 'package:apo/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:apo/features/checkout/domain/usecases/create_transfer_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/get_sheet_type_options_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/get_ship_via_options_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/get_transfer_type_options_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/get_transfer_selections_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/request_quote_usecase.dart';
import 'package:apo/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:apo/features/home/data/repositories/products_repository_impl.dart';
import 'package:apo/features/home/data/repositories/cart_repository_impl.dart';
import 'package:apo/features/home/data/services/cart_api_service.dart';
import 'package:apo/features/home/data/services/products_api_service.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';
import 'package:apo/features/home/domain/repositories/products_repository.dart';
import 'package:apo/features/home/domain/usecases/add_cart_item_usecase.dart';
import 'package:apo/features/home/domain/usecases/checkout_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_cart_items_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_product_details_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_products_usecase.dart';
import 'package:apo/features/home/presentation/cubits/cart_cubit.dart';
import 'package:apo/features/home/presentation/cubits/product_details_cubit.dart';
import 'package:apo/features/home/presentation/cubits/products_cubit.dart';
import 'package:apo/features/home/presentation/cubits/profile_cubit.dart';
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

  final token = await secureStorage.read(key: SecureStorageKey.authToken);
  if (token.isNotNullOrEmpty()) {
    DioFactory.setAuthToken(token);
  }

  getIt.registerLazySingleton<Dio>(() => DioFactory.create());

  getIt.registerFactory(() => LoginCubit(getIt<LoginUseCase>()));
  getIt.registerFactory(() => ProductsCubit(getIt<GetProductsUseCase>()));
  getIt.registerLazySingleton<CartCubit>(
    () => CartCubit(
      getIt<AddCartItemUseCase>(),
      getIt<GetCartItemsUseCase>(),
    ),
  );
  getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
  getIt.registerFactoryParam<ProductDetailsCubit, int, void>(
    (productId, _) => ProductDetailsCubit(
      getIt<GetProductDetailsUseCase>(),
      productId: productId,
    ),
  );
  getIt.registerFactoryParam<CheckoutCubit, CheckoutType, void>(
    (type, _) => CheckoutCubit(
      getIt<RequestQuoteUseCase>(),
      getIt<CheckoutUseCase>(),
      getIt<GetShipViaOptionsUseCase>(),
      getTransferSelectionsUseCase: getIt<GetTransferSelectionsUseCase>(),
      createTransferUseCase: getIt<CreateTransferUseCase>(),
      getTransferTypeOptionsUseCase: getIt<GetTransferTypeOptionsUseCase>(),
      getSheetTypeOptionsUseCase: getIt<GetSheetTypeOptionsUseCase>(),
      type: type,
    ),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthenticationRepository>()),
  );
  getIt.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(getIt<ProductsRepository>()),
  );
  getIt.registerLazySingleton<AddCartItemUseCase>(
    () => AddCartItemUseCase(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<GetCartItemsUseCase>(
    () => GetCartItemsUseCase(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<RequestQuoteUseCase>(
    () => RequestQuoteUseCase(getIt<CheckoutRepository>()),
  );
  getIt.registerLazySingleton<CheckoutUseCase>(
    () => CheckoutUseCase(getIt<CheckoutRepository>()),
  );
  getIt.registerLazySingleton<GetShipViaOptionsUseCase>(
    () => GetShipViaOptionsUseCase(getIt<CheckoutRepository>()),
  );
  getIt.registerLazySingleton<GetTransferSelectionsUseCase>(
    () => GetTransferSelectionsUseCase(getIt<CheckoutRepository>()),
  );
  getIt.registerLazySingleton<GetTransferTypeOptionsUseCase>(
    () => GetTransferTypeOptionsUseCase(getIt<CheckoutRepository>()),
  );
  getIt.registerLazySingleton<GetSheetTypeOptionsUseCase>(
    () => GetSheetTypeOptionsUseCase(getIt<CheckoutRepository>()),
  );
  getIt.registerLazySingleton<CreateTransferUseCase>(
    () => CreateTransferUseCase(getIt<CheckoutRepository>()),
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
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt<CartApiService>()),
  );

  getIt.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(getIt<CheckoutApiService>()),
  );

  getIt.registerLazySingleton<AuthenticationApiService>(
    () => AuthenticationApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ProductsApiService>(
    () => ProductsApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<CartApiService>(
    () => CartApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<CheckoutApiService>(
    () => CheckoutApiService(getIt<Dio>()),
  );
}
