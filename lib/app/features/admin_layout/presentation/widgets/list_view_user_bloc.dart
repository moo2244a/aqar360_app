import 'package:aqar360/app/features/admin_layout/presentation/cubit/AdminUsers/admin_users_cubit.dart';
import 'package:aqar360/app/features/admin_layout/presentation/cubit/AdminUsers/admin_users_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewUsersBloc extends StatelessWidget {
  const ListViewUsersBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminUsersCubit, AdminUsersState>(
      builder: (context, state) {
        if (state is AdminUsersLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminUsersError) {
          return Center(child: Text(state.message));
        }

        if (state is AdminUsersLoaded) {
          final users = state.users;

          if (users.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return ListTile(
                leading: CircleAvatar(child: Text(user.name?[0] ?? '?')),
                title: Text(user.name ?? 'Unknown User'),
                subtitle: Text(user.email),
                trailing: Switch(
                  value: user.isBlock ?? false,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    AdminUsersCubit.get(context).toggleBlockStatus(user, value);
                  },
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
