// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/usecases/changing_order_state_usecase.dart';
import 'package:food_app/domain/usecases/delete_ordere_usecase.dart';
import 'package:food_app/domain/usecases/get_realtime_orders_usecase.dart';
import 'package:food_app/presentation/admin/admin_cubit/admin_states.dart';

import '../../../app/di.dart';
import '../../../domain/model/models.dart';
import '../../../domain/usecases/get_orders_fromFirebase_usecase.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  final GetOrdersFromFirebaseUseCase _getOrdersFromFirebaseUseCase = GetOrdersFromFirebaseUseCase(instance());
  final DeleteOrderUseCase _deleteOrderUseCase = DeleteOrderUseCase(instance());
  final ChangingOrderStateUsecase _changingOrderStateUsecase = ChangingOrderStateUsecase(instance());
  final GetRealtimeOrdersUsecase _getRealtimeOrdersUsecase = GetRealtimeOrdersUsecase(instance());

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

  Stream<List<ClientAllOrders>> getRealtimeOrders() {
    return _getRealtimeOrdersUsecase.start();
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

  void changeOrderState(String orderId, OrderState orderState) async {
    emit(ChangeOrderStateLoadingState());
    (await _changingOrderStateUsecase.start(ChangingOrderStateObject(orderId, orderState))).fold(
      (failure) {
        emit(ChangeOrderStateErrorState(failure.message));
      },
      (data) {
        emit(ChangeOrderStateSuccessState());
      },
    );
  }
}
