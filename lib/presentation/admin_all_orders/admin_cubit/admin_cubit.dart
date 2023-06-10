import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/usecases/delete_ordere_usecase.dart';
import 'package:food_app/presentation/admin_all_orders/admin_cubit/admin_states.dart';

import '../../../app/di.dart';
import '../../../domain/model/models.dart';
import '../../../domain/usecases/get_orders_fromFirebase_usecase.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  final GetOrdersFromFirebaseUseCase _getOrdersFromFirebaseUseCase = GetOrdersFromFirebaseUseCase(instance());
  final DeleteOrderUseCase _deleteOrderUseCase = DeleteOrderUseCase(instance());

// GET ORDERS :
  List<ClientAllOrders> clientsOrders = [];

  void getOrdersFromFirebase() async {
    emit(GetOrdersFromFirebaseLoadingState());
    (await _getOrdersFromFirebaseUseCase.start(Void)).fold(
      (failure) {
        print("🛑 clients Orders 🛑");

        emit(GetOrdersFromFirebaseErrorState(failure.message));
      },
      (data) {
        clientsOrders = data;
        emit(GetOrdersFromFirebaseSuccessState());
        print("🐦 clients Orders 🐦");
        // print(data.length);
        // print(data.first.orders.length);
        // print(data.first.orders.first.quentity);
      },
    );
  }

  void deleteOrder(String id) async {
    emit(DeleteOrderFromFirebaseLoadingState());
    (await _deleteOrderUseCase.start(id)).fold(
      (failure) {
        print("delete error");
        emit(DeleteOrderFromFirebaseErrorState(failure.message));
      },
      (data) {
        print("delete sucess");
        emit(DeleteOrderFromFirebaseSuccessState());
      },
    );
  }

  // void deleteOrder(String id) async {
  //   await _deleteOrderUseCase.start(id);
  //   emit(DeleteOrderFromFirebaseSuccessState());
  // }
}
