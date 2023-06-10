import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';

import '../resources/strings_manager.dart';

class AdminAllItems extends StatelessWidget {
  const AdminAllItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = BaseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.adminAllItemsScreen.toUpperCase()),
          ),
          body: Column(
            children: [
              ListView.builder(
                itemCount: cubit.items.length,
                itemBuilder: (context, index) {
                  return null;
                },
              )
            ],
          ),
        );
      },
    );
  }
}
