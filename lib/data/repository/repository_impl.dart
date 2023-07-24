// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/data/data_source/remote_data_source.dart';
import 'package:food_app/data/mapper/mapper.dart';
import 'package:food_app/data/network/error_handler.dart';
import 'package:food_app/data/response/responses.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:http/src/response.dart';

import '../network/firebase_auth.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, void>> userCreate(UserRegister userRegister) async {
    if (await _networkInfo.isConnected) {
      try {
        _remoteDataSource.userCreate(userRegister);
        return right(Void);
      } catch (e) {
        return left(Failure(e.hashCode.toString(), e.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> userRegister(UserRegister userRegister) async {
    if (await _networkInfo.isConnected) {
      try {
        _remoteDataSource.userRegister(userRegister);
        return right(Void);
      } catch (e) {
        return left(Failure(e.hashCode.toString(), e.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, OtpCheckModel>> otpCheck(String verificationId, String smsCode) async {
    if (await _networkInfo.isConnected) {
      try {
        var document = await _remoteDataSource.otpCheck(verificationId, smsCode);
        return right(document);
      } on FirebaseAuthException catch (e) {
        return left(Failure(e.code, e.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> verifyPhoneNumber(VerifyPhoneNumberModel varifyPhoneNumberModel) async {
    if (await _networkInfo.isConnected) {
      try {
        _remoteDataSource.verifyPhoneNumber(varifyPhoneNumberModel);
        return right(Void);
      } on FirebaseAuthException catch (e) {
        return left(Failure(e.code, e.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CustomerObject>> getUserData(String uid) async {
    if (await _networkInfo.isConnected) {
      try {
        CustomerResponse customerResponse = await _remoteDataSource.getUserData(uid);
        return right(customerResponse.toDomain());
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<ItemObject>>> getPopularItems() async {
    if (await _networkInfo.isConnected) {
      try {
        List<ItemResponse> popularItems = await _remoteDataSource.getPopularItems();
        return right(popularItems.map((e) => e.toDomain()).toList());
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<ItemObject>>> getItems() async {
    if (await _networkInfo.isConnected) {
      try {
        List<ItemResponse> items = await _remoteDataSource.getItems();
        return right(items.map((e) => e.toDomain()).toList());
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> sentOrderToFirebase(ClientAllOrders orders) async {
    if (await _networkInfo.isConnected) {
      try {
        return right(await _remoteDataSource.sentOrderToFirebase(orders));
      } catch (error) {
        return left(Failure(error.hashCode.toString(), error.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<ClientAllOrders>>> getOrdersFromFirebase() async {
    if (await _networkInfo.isConnected) {
      try {
        List<ClientAllOrdersResponse> ordersReponse = await _remoteDataSource.getOrdersFromFirebase();
        return right(ordersReponse.map((ordersResponse) => ordersResponse.toDomain()).toList());
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.deleteOrder(id);
        return right(Void);
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addNewMealItem(AddNewMealObject addNewMealObject) async {
    if (await _networkInfo.isConnected) {
      try {
        _remoteDataSource.addNewMealItem(addNewMealObject);
        return right(Void);
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteMeal(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        _remoteDataSource.deleteMeal(id);
        return right(Void);
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Stream<String> getRealTimeOrderState(String id) {
    return _remoteDataSource.getRealTimeOrderState(id);
    // if (await _networkInfo.isConnected) {
    //   try {
    //     return right(_remoteDataSource.getRealTimeOrderState(id));
    //   } catch (e) {
    //     return left(Failure(e.hashCode.toString(), e.toString()));
    //   }
    // } else {
    //   return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  @override
  Future<Either<Failure, void>> changingOrderState(ChangingOrderStateObject object) async {
    if (await _networkInfo.isConnected) {
      try {
        return right(await _remoteDataSource.changingOrderState(object));
      } catch (e) {
        return left(Failure(e.hashCode.toString(), e.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Stream<List<ClientAllOrders>> getRealtimeOrders() {
    return _remoteDataSource.getRealtimeOrders().map(
      (event) {
        return event.map((clientAllOrdersResponse) {
          return clientAllOrdersResponse.toDomain();
        }).toList();
      },
    );
  }

  @override
  Future<Either<Failure, void>> addItemToFavoriteList(AddToFavoriteObject addToFavoriteObject) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.addItemToFavoriteList(addToFavoriteObject);
        return right(Void);
      } catch (error) {
        return left(Failure(error.hashCode.toString(), error.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeItemFromFavoriteList(AddToFavoriteObject addToFavoriteObject) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.removeItemFromFavoriteList(addToFavoriteObject);
        return right(Void);
      } catch (error) {
        return left(Failure(error.hashCode.toString(), error.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getIsStoreOpen() async {
    if (await _networkInfo.isConnected) {
      try {
        var isOpen = await _remoteDataSource.getIsStoreOpen();
        return right(isOpen);
      } catch (e) {
        print("repository error ${e.toString()}");
        return left(Failure(e.hashCode.toString(), e.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changeIsStoreOpen() async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.changeIsStoreOpen();
        return right(Void);
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveToken(String token) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.saveToken(token);
        return right(Void);
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Response>> sentPushNotification(String token, String notificationBody) async {
    if (await _networkInfo.isConnected) {
      try {
        Response res = await _remoteDataSource.sentPushNotification(token, notificationBody);
        return right(res);
      } catch (e) {
        return left(Failure('0', 'push notification error : $e'));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
