import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/domain/usecases/get_home_data.dart';
import 'package:food_app/domain/usecases/get_items_usecase.dart';
import 'package:food_app/domain/usecases/get_popular_items_usecase.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';

import '../../../app/app_pref.dart';
import '../../../app/di.dart';
import '../view/pages/home/view/home_screen.dart';
import '../view/pages/profile/view/profile_screen.dart';
import '../view/pages/search/view/search_screen.dart';
import '../view/pages/cart/view/cart_screen.dart';

class BaseCubit extends Cubit<BaseStates> {
  BaseCubit() : super(BaseInitialState());

  static BaseCubit get(context) => BlocProvider.of(context);

  final GetUserDataUsecase _getUserDataUsecase = GetUserDataUsecase(instance());
  final AppPrefrences _appPrefrences = AppPrefrences(instance());
  final GetPopularItemsUsecase _getPopularItemsUsecase = GetPopularItemsUsecase(instance());
  final GetItemsUsecase _getItemsUsecase = GetItemsUsecase(instance());

  CustomerObject? customerObject;

  // home screen ::

  int currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void onTap(int index) {
    emit(BaseChangeIndexState());
    currentIndex = index;
  }

  // get user data ::

  Future<String> getUserId() async {
    return await _appPrefrences.getUserId();
  }

  void getUserData(String uid, BuildContext context) async {
    emit(BaseGetUserDataLoadingState());
    (await _getUserDataUsecase.start(await getUserId())).fold(
      (failure) {
        emit(BaseGetUserDataErrorState(failure.message));
      },
      (customerObjectData) {
        emit(BaseGetUserDataSuccessState());
        customerObject = customerObjectData;
      },
    );
    return null;
  }

  // get Items ::

  List<ItemObject> popularItems = [];

  void getPopularItems() async {
    emit(BaseGetPopularItemsLoadingState());
    (await _getPopularItemsUsecase.start(Void)).fold(
      (failure) {
        emit(BaseGetPopularItemsErrorState(failure.message));
      },
      (data) {
        emit(BaseGetPopularItemsSuccessState());
        popularItems = data;
        print("🐦popular itmes🐦");
        print(data.length);
      },
    );
  }

  List<ItemObject> items = [];

  void getItems() async {
    emit(BaseGetItemsLoadingState());
    (await _getItemsUsecase.start(Void)).fold(
      (failure) {
        emit(BaseGetItemsErrorState(failure.message));
      },
      (data) {
        emit(BaseGetItemsSuccessState());
        items = data;
        print("🐦 itmes🐦");
        print(data.length);
      },
    );
  }

  // Cart & Order

  List<Order> orders = [];

  void addOrder(Order order) {
    bool orderExiste = orders.any((element) => element.itemObject == order.itemObject);
    if (!orderExiste) {
      emit(BaseAddOrderSuccessState());
      orders.add(order);
      print("ADD ORDER 🐦🐦🐦");
    } else {
      emit(BaseAddOrderErrorState(AppStrings.orderAlreadyExist));
    }
  }

  void removeOrder(Order order) {
    orders.remove(order);
    emit(BaseRemoveOrderSuccessState());
  }
}
