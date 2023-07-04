// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/domain/usecases/add_item_to_favorite_list_usecase.dart';
import 'package:food_app/domain/usecases/delete_meal_usecase.dart';
import 'package:food_app/domain/usecases/get_is_store_open_usecase.dart';
import 'package:food_app/domain/usecases/get_user_data.dart';
import 'package:food_app/domain/usecases/get_items_usecase.dart';
import 'package:food_app/domain/usecases/get_popular_items_usecase.dart';
import 'package:food_app/domain/usecases/get_real_time_order_state_usecase.dart';
import 'package:food_app/domain/usecases/remove_item_from_favorite_list_usecase.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:url_launcher/url_launcher_string.dart';

import '../../../app/app_pref.dart';
import '../../../app/di.dart';
import '../../../domain/usecases/change_is_store_open_usecase.dart';
import '../../../domain/usecases/sent_orders_tofirebase_ucecase.dart';
import '../view/pages/home/view/home_screen.dart';
import '../view/pages/profile/view/profile_screen.dart';
import '../view/pages/search/view/search_screen.dart';
import '../view/pages/cart/view/cart_screen.dart';

import 'package:geocoding/geocoding.dart' as geocoding;

class BaseCubit extends Cubit<BaseStates> {
  BaseCubit() : super(BaseInitialState());

  static BaseCubit get(context) => BlocProvider.of(context);

  final GetUserDataUsecase _getUserDataUsecase = GetUserDataUsecase(instance());
  final AppPrefrences _appPrefrences = AppPrefrences(instance());
  final GetPopularItemsUsecase _getPopularItemsUsecase = GetPopularItemsUsecase(instance());
  final GetItemsUsecase _getItemsUsecase = GetItemsUsecase(instance());
  final SentOrderToFirebaseUsecase _sentOrderToFirebaseUsecase = SentOrderToFirebaseUsecase(instance());
  final DeleteMealUsecase _deleteMealUsecase = DeleteMealUsecase(instance());
  final GetRealTimeOrderState _getRealTimeOrderState = GetRealTimeOrderState(instance());
  final AddItemToFavoriteListUsecase _addItemToFavoriteListUsecase = AddItemToFavoriteListUsecase(instance());
  final RemoveItemFromFavoriteListUsecase _removeItemFromFavoriteListUsecase =
      RemoveItemFromFavoriteListUsecase(instance());
  final GetIsStoreOpenUsecase _getIsStoreOpenUsecase = GetIsStoreOpenUsecase(instance());
  final ChangeIsStoreOpenUsecase _changeIsStoreOpenUsecase = ChangeIsStoreOpenUsecase(instance());

  CustomerObject? customerObject;

  // is store open

  bool isStoreOpen = true;

  void getIsStoreOpen() async {
    emit(GetIsStoreOpenLoadingState());
    (await _getIsStoreOpenUsecase.start(Void)).fold(
      (failure) {
        emit(GetIsStoreOpenErrorState(failure.message));
      },
      (data) {
        isStoreOpen = data;
        print("🌟 IS STORE OPEN :: $isStoreOpen");
        emit(GetIsStoreOpenSuccessState());
      },
    );
  }

  void changeIsStoreOpen() async {
    emit(ChangeIsStoreOpenLoadingState());
    (await _changeIsStoreOpenUsecase.start(Void)).fold(
      (failure) {
        print("change is store open error ${failure.message}");
        emit(ChangeIsStoreOpenErrorState(failure.message));
      },
      (r) {
        getIsStoreOpen();
        emit(ChangeIsStoreOpenSuccessState());
      },
    );
  }

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

  void getUserData() async {
    emit(BaseGetUserDataLoadingState());
    (await _getUserDataUsecase.start(await getUserId())).fold(
      (failure) {
        emit(BaseGetUserDataErrorState(failure.message));
      },
      (customerObjectData) {
        print("✅ GET USER DATA ✅");
        customerObject = customerObjectData;
        emit(BaseGetUserDataSuccessState());
      },
    );
    // return null;
  }

  // get Items ::

  List<ItemObject> popularItems = [];

  void getPopularItems() async {
    emit(BaseGetPopularItemsLoadingState());
    (await _getPopularItemsUsecase.start(Void)).fold(
      (failure) {
        print("🛑popular itmes🛑");
        print(failure.message);

        emit(BaseGetPopularItemsErrorState(failure.message));
      },
      (data) {
        print("✅ GET POPULAR ITEMS ✅");
        popularItems = data;
        emit(BaseGetPopularItemsSuccessState());
        // print("🐦popular itmes🐦");
        // print(data.length);
      },
    );
  }

  List<ItemObject> items = [];

  void getItems() async {
    emit(BaseGetItemsLoadingState());
    (await _getItemsUsecase.start(Void)).fold(
      (failure) {
        emit(BaseGetItemsErrorState(failure.message));
        print("🛑items🛑");
        print(failure.message);
      },
      (data) {
        print("✅ GET ALL ITEMS ✅");
        items = data;
        emit(BaseGetItemsSuccessState());
        // print("🐦 itmes🐦");
        // print(data.length);
      },
    );
  }

  // Cart & Order

  List<Order> userOrders = [];

  String? orderID;

  void addOrder(Order order) {
    bool orderExiste = userOrders.any((element) => element.itemObject == order.itemObject);
    if (!orderExiste) {
      userOrders.add(order);
      emit(BaseAddOrderToCartSuccessState());
    } else {
      emit(BaseAddOrderToCartErrorState(AppStrings.orderAlreadyExist));
    }
  }

  void removeOrder(Order order) {
    userOrders.remove(order);
    emit(BaseRemoveOrderSuccessState());
  }

  void sentOrderToFirebase() async {
    emit(SentOrderToFirebaseLoadingState());
    if (userOrders.isNotEmpty) {
      (await _sentOrderToFirebaseUsecase.start(
        ClientAllOrders(
          userOrders,
          customerObject!.phoneNumber,
          placeName!,
          "",
          getFormattedDateTime(DateTime.now()),
          OrderState.WAITING,
        ),
      ))
          .fold(
        (l) {
          emit(SentOrderToFirebaseErrorState(l.message));
        },
        (data) {
          userOrders = [];
          orderID = data;
          getRealTimeOrderState(orderID!);
          emit(SentOrderToFirebaseSuccessState());
        },
      );
    }
  }

  // get order State live ::

  Stream<String> getRealTimeOrderState(String id) {
    return _getRealTimeOrderState.start(id);
  }

  Widget getStateWidget(String state, BuildContext context) {
    if (OrderState.PREPARING.toString().split('.').last == state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.preparingYourOrder,
            style: getlargeStyle(color: ColorManager.orange),
          ),
          LottieBuilder.asset(
            LottieAsset.burgerMachine,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ],
      );
    }
    if (OrderState.DELIVERING.toString().split('.').last == state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.deliveringYourOrder,
            style: getlargeStyle(color: ColorManager.orange),
          ),
          LottieBuilder.asset(
            LottieAsset.delivery,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ],
      );
    }
    if (OrderState.FINISHED.toString().split('.').last == state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.yourOrderHasBeenDelivered,
            style: getlargeStyle(color: ColorManager.orange),
          ),
          LottieBuilder.asset(
            LottieAsset.orderRecived,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          TextButton(
            onPressed: () {
              orderID = null;
              emit(OrderDoneState());
            },
            child: Text(
              'DONE',
              style: getlargeStyle(color: ColorManager.orange),
            ),
          )
        ],
      );
    } else
    // (OrderState.WAITING.toString().split('.').last == state)
    {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.waitingForYourTurn,
            style: getlargeStyle(color: ColorManager.orange),
          ),
          LottieBuilder.asset(
            LottieAsset.blueBirdWaiting,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ],
      );
    }
  }

  // Admin  delete item

  void deleteItem(String id) async {
    await _deleteMealUsecase.start(id);
  }

  List<ItemObject> getItemsByCategory(ItemCategory itemCategory) {
    emit(GetMealsByCategoryState());

    return items
        .where(
          (item) => item.category == itemCategory,
        )
        .toList();
  }

  List<ItemObject> getItemsByCategoryWithoutItemItSelf(ItemObject itemObject) {
    emit(GetMealsByCategoryState());

    return items
        .where(
          (item) => item.category == itemObject.category && item.id != itemObject.id,
        )
        .toList();
  }

  // Search item by name

  TextEditingController searchController = TextEditingController();

  List<ItemObject> searchedItem = [];

  void searchItemByName() {
    searchController.text.isNotEmpty
        ? searchedItem = items.where(
            (item) {
              if (item.title.toLowerCase().contains(searchController.text)) {
                return item.title.toLowerCase().contains(searchController.text);
              }
              if (item.title.toUpperCase().contains(searchController.text)) {
                return item.title.toUpperCase().contains(searchController.text);
              } else {
                return item.title.contains(searchController.text);
              }
            },
          ).toList()
        : searchedItem = [];
    emit(SearchItemState());
  }

  // ADD item to favorite list

  void addItemToFavoriteList(String itemId) async {
    emit(AddItemToFavoriteLoadingState());
    (await _addItemToFavoriteListUsecase.start(AddToFavoriteObject(customerObject!.uid, itemId))).fold(
      (failure) {
        emit(AddItemToFavoriteErrorState(failure.message));
      },
      (r) {
        print('🇩🇿item added to favorite');
        getUserData();
        emit(AddItemToFavoriteSuccessState());
      },
    );
  }

  // REMOVE item from favorite list

  void removeItemFromFavoriteList(String itemId) async {
    emit(RemoveItemFromFavoriteLoadingState());
    (await _removeItemFromFavoriteListUsecase.start(AddToFavoriteObject(customerObject!.uid, itemId))).fold(
      (failure) {
        emit(RemoveItemFromFavoriteErrorState(failure.message));
      },
      (r) {
        print('🇩🇿remove item  from favorite');
        getUserData();
        emit(RemoveItemFromFavoriteSuccessState());
      },
    );
  }

  // favorite screen
  List<ItemObject> favoriteItems = [];

  void getFavoriteItems() {
    favoriteItems = items.where(
      (element) {
        return customerObject!.favoriteItems.contains(element.id);
      },
    ).toList();
  }

  // LOCATION ::

  double? latitude;
  double? longitude;

  Future<Position> getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());

    // check is service location in user phone enabled or not ::

    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      emit(GetCurrentLocationErrorState('location service disabled'));
      print('🛑 location service disabled');
      // return Future.error('🛑 location service disabled');
    }

    // check the permission to get user location ::

    LocationPermission permission = await Geolocator.checkPermission();
    print('🌟 location permission :: $permission');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(GetCurrentLocationErrorState("Location permissions are denied"));
        print("🛑 Location permissions are denied");
        return Future.error("🛑 Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(GetCurrentLocationErrorState("Location permissions are permanently denied, we cannot request"));
      print("🛑 Location permissions are permanently denied, we cannot request");
      return Future.error("🛑 Location permissions are permanently denied, we cannot request");
    }

    // after getting the permission we can get the current location ::

    return await Geolocator.getCurrentPosition().then(
      (value) async {
        latitude = value.latitude;
        longitude = value.longitude;
        await getLocationName();
        emit(GetCurrentLocationSuccessState());
        return value;
      },
    );
  }

  String? placeName;
  Future<void> getLocationName() async {
    // emit(GetLocationNameLoadingState());

    await geocoding.placemarkFromCoordinates(latitude!, longitude!).then(
      (List<Placemark> value) {
        placeName = value[0].name ?? 'kais';
        print("✅ GET LOCATION ✅");
        // emit(GetLocationNameSuccessState());
      },
    ).catchError(
      (error) {
        print("get place name Error $error");
        // emit(GetLocationNameErrorState(error));
      },
    );
  }

  Future<void> openMap() async {
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    print(googleUrl);

    await canLaunchUrlString(googleUrl) ? await launchUrlString(googleUrl) : throw "can't launch URL $googleUrl";
  }

  // Future<void> openLocation() async {
  //   String googleUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

// if (await canLaunch(googleUrl)) {
//     await launch(googleUrl);
//   } else {
//     throw "Couldn't launch URL: $googleUrl";
//   }
//   }
}
