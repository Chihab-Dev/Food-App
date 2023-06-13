import 'package:food_app/domain/repository/repostitory.dart';

class GetRealTimeOrderState {
  final Repository _repository;

  GetRealTimeOrderState(this._repository);

  Stream<String> start(String input) {
    return _repository.getRealTimeOrderState(input);
  }
}
