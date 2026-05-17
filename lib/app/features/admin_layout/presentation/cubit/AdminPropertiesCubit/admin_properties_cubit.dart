import 'package:aqar360/app/features/admin_layout/domain/usecases/update_property_status_usecase.dart';
import 'package:aqar360/app/features/admin_layout/presentation/cubit/AdminPropertiesCubit/admin_properties_state.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/admin_layout/domain/usecases/get_pending_properties_usecase.dart';
import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/core/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPropertiesCubit extends Cubit<AdminPropertiesState> {
  AdminPropertiesCubit({
    required this.getPendingProperties,
    required this.updatePropertyStatus,
  }) : super(AdminPropertiesInitial());

  final GetPendingPropertiesUsecase getPendingProperties;
  final UpdatePropertyStatusUsecase updatePropertyStatus;
  static AdminPropertiesCubit get(BuildContext context) =>
      BlocProvider.of<AdminPropertiesCubit>(context);
  List<PropertyDetails> _properties = [];

  Future<void> fetchProperties() async {
    emit(AdminPropertiesLoading());

    try {
      final properties = await getPendingProperties();
      _properties = properties;

      emit(AdminPropertiesLoaded(properties));
    } catch (e) {
      emit(AdminPropertiesError('Error fetching properties: $e'));
    }
  }

  Future<void> approveProperty(PropertyDetails property) async {
    if (property.id == null) return;

    try {
      await updatePropertyStatus(
        propertyId: property.id!,
        status: PropertyStatus.active,
      );

      // Send notification to user
      if (property.ownerId != null) {
        await FirebaseHelper.addNotification(
          NotificationModel(
            id: '',
            userId: property.ownerId!,
            title: "تم قبول عقارك",
            body:
                "تم مراجعة عقارك (${property.title ?? 'بدون عنوان'}) وقبوله بنجاح.",
            createdAt: DateTime.now(),
            type: "accepted_property",
            relatedId: property.id,
          ),
        );
      }

      _properties.removeWhere((p) => p.id == property.id);

      emit(AdminPropertiesLoaded(List.from(_properties)));
      emit(AdminPropertiesSuccess('Property approved successfully'));
    } catch (e) {
      emit(AdminPropertiesError('Error approving property: $e'));
    }
  }

  Future<void> rejectProperty({
    required PropertyDetails property,
    required String reason,
  }) async {
    if (property.id == null) return;

    emit(AdminPropertiesLoading());

    try {
      await updatePropertyStatus(
        propertyId: property.id!,
        status: PropertyStatus.rejected,
        rejectionReason: reason,
      );

      // Send notification to user
      if (property.ownerId != null) {
        await FirebaseHelper.addNotification(
          NotificationModel(
            id: '',
            userId: property.ownerId!,
            title: "تم إرجاع عقارك للتعديل",
            body: "سبب الرفض: $reason",
            createdAt: DateTime.now(),
            type: "rejected_property",
            relatedId: property.id,
          ),
        );
      }

      _properties.removeWhere((p) => p.id == property.id);

      emit(AdminPropertiesLoaded(List.from(_properties)));
      emit(AdminPropertiesSuccess('Property rejected successfully'));
    } catch (e) {
      emit(AdminPropertiesError('Error rejecting property: $e'));
    }
  }
}
