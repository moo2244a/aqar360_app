import 'package:aqar360/app/features/addProperty/domain/entities/property_dependencies.dart';

import 'package:aqar360/app/features/admin_layout/presentation/cubit/AdminPropertiesCubit/admin_properties_cubit.dart';
import 'package:aqar360/app/features/admin_layout/presentation/widgets/list_view_properties_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPropertiesScreen extends StatelessWidget {
  const AdminPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final property = PropertyDependencies.create();

        return AdminPropertiesCubit(
          getPendingProperties: property.getPendingPropertiesUsecase,
          updatePropertyStatus: property.updatePropertyStatusUsecase,
        )..fetchProperties();
      },
      child: ListViewPropertiesBloc(),
    );
  }
}
