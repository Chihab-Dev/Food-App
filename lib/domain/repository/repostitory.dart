import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/model/models.dart';

abstract class Repository {
  Future<Either<Failure, CustomerObject>> getUserData(String uid);
}
