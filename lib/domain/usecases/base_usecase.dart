import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';

abstract class BaseUsecase<In, Out> {
  Future<Either<Failure, Out>> start(In input);
}
