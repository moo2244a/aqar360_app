import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/admin_layout/presentation/cubit/AdminPropertiesCubit/admin_properties_cubit.dart';
import 'package:aqar360/app/features/admin_layout/presentation/cubit/AdminPropertiesCubit/admin_properties_state.dart';
import 'package:aqar360/app/features/search/presentation/widgets/property_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewPropertiesBloc extends StatelessWidget {
  const ListViewPropertiesBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminPropertiesCubit, AdminPropertiesState>(
      builder: (context, state) {
        if (state is AdminPropertiesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminPropertiesLoaded) {
          final properties = state.properties;

          if (properties.isEmpty) {
            return const Center(child: Text("No pending properties"));
          }

          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      PropertyCard(property: property),
                      PropertyActionButtons(property: property),
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (state is AdminPropertiesError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}

class PropertyActionButtons extends StatelessWidget {
  final PropertyDetails property;

  const PropertyActionButtons({super.key, required this.property});
  Future<void> _rejectPropertyDialog(
    PropertyDetails property,
    BuildContext context,
  ) async {
    if (property.id == null) return;

    final TextEditingController reasonController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context1) {
        return AlertDialog(
          title: const Text("Reject Property"),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              hintText: "Enter rejection reason",
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final reason = reasonController.text.trim();
                if (reason.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a reason")),
                  );
                  return;
                }
                AdminPropertiesCubit.get(
                  context,
                ).rejectProperty(property: property, reason: reason);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Reject"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => _rejectPropertyDialog(property, context),
          child: const Text("Reject", style: TextStyle(color: Colors.red)),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            AdminPropertiesCubit.get(context).approveProperty(property);
          },
          child: const Text("Approve"),
        ),
      ],
    );
  }
}
