import 'package:aqar360/app/features/admin_layout/domain/entities/user_dependencies.dart';

import 'package:aqar360/app/features/admin_layout/presentation/cubit/AdminUsers/admin_users_cubit.dart';
import 'package:aqar360/app/features/admin_layout/presentation/widgets/list_view_user_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final user = UserDependencies.create();

        return AdminUsersCubit(
          getAllUsersUsecase: user.getAllUsersUsecase,
          updateUserBlockStatus: user.updateUserBlockStatusUsecase,
        )..fetchUsers();
      },
      child: ListViewUsersBloc(),
    );
  }
}
