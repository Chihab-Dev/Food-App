import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/data/data_source/remote_data_source.dart';
import 'package:food_app/data/mapper/mapper.dart';
import 'package:food_app/data/network/error_handler.dart';
import 'package:food_app/data/response/responses.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_app/domain/repository/repostitory.dart';

import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

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
  Future<Either<Failure, void>> sentOrderToFirebase(Orders orders) async {
    if (await _networkInfo.isConnected) {
      try {
        return right(_remoteDataSource.sentOrderToFirebase(orders));
      } on FirebaseException catch (error) {
        return left(Failure(error.code, error.message.toString()));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
