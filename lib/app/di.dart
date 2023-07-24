import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/app/app_pref.dart';
import 'package:food_app/data/data_source/remote_data_source.dart';
import 'package:food_app/data/network/fcm.dart';
import 'package:food_app/data/network/firebase_auth.dart';
import 'package:food_app/data/network/firebase_store.dart';
import 'package:food_app/data/network/network_info.dart';
import 'package:food_app/data/repository/repository_impl.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/get_user_data.dart';
import 'package:food_app/domain/usecases/get_items_usecase.dart';
import 'package:food_app/domain/usecases/get_popular_items_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance.registerLazySingleton<AppPrefrences>(() => AppPrefrences(instance()));

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  instance.registerLazySingleton<FirebaseStoreClient>(() => FirebaseStoreClient(firestore));

  instance.registerLazySingleton<Fcm>(() => Fcm());

  instance.registerLazySingleton<FirebaseAuthentication>(() => FirebaseAuthentication(auth));

  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance(), instance(), instance()));

  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance()));
}

initHomeData() {
  if (!GetIt.I.isRegistered<GetUserDataUsecase>()) {
    instance.registerFactory<GetUserDataUsecase>(() => GetUserDataUsecase(instance()));

    // instance.registerFactory<HomeCubit>(() => HomeCubit(instance(), instance()));

    instance.registerFactory<GetPopularItemsUsecase>(() => GetPopularItemsUsecase(instance()));
    instance.registerFactory<GetItemsUsecase>(() => GetItemsUsecase(instance()));
  }
}
