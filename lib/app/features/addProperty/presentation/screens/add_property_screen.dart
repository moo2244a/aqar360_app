// add_property_screen.dart

import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:aqar360/app/core/usecases/section_title.dart';
import 'package:aqar360/app/core/usecases/snak_bar_message.dart';

import 'package:aqar360/app/features/addProperty/domain/entities/property_dependencies.dart';

import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_state.dart';

import 'package:aqar360/app/features/addProperty/presentation/widgets/apartment_fields.dart';

import 'package:aqar360/app/features/addProperty/presentation/widgets/land_widget.dart';

import 'package:aqar360/app/features/addProperty/presentation/widgets/property_details_form.dart';
import 'package:aqar360/app/features/addProperty/presentation/widgets/property_type_selector.dart';
import 'package:aqar360/app/features/addProperty/presentation/widgets/villa_fields.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();

  // ─── Shared Fields ───
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _areaController = TextEditingController();
  final _streetWidthController = TextEditingController();
  final _propertyDetails = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _areaController.dispose();
    _streetWidthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: BlocProvider<AddPropertyCubit>(
        create: (context) {
          final property = PropertyDependencies.create();
          return AddPropertyCubit(
            addPropertyUsecase: property.addPropertyUsecase,
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.appBarTitle,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: AppColors.black),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ══════════════════════════
                // Step 1: اختيار النوع
                // ══════════════════════════
                SectionTitle(title: AppStrings.sectionPropertyType),
                const SizedBox(height: 15),
                PropertyTypeSelector(),

                const SizedBox(height: 24),

                // ══════════════════════════
                // الصور
                // ══════════════════════════
                SectionTitle(title: AppStrings.sectionPropertyImages),
                const SizedBox(height: 12),
                BlocBuilder<AddPropertyCubit, AddPropertyState>(
                  builder: (context, state) {
                    final images = state.details.imagesUrl ?? [];

                    return CustomAddImage(
                      images: images,
                      isLoading: state is AddPropertyImageLoading,
                      onTap: AddPropertyCubit.get(context).addPropertyImage,
                    );
                  },
                ),

                const SizedBox(height: 24),
                SectionTitle(title: AppStrings.sectionPropertyDocImages),
                const SizedBox(height: 12),
                BlocConsumer<AddPropertyCubit, AddPropertyState>(
                  builder: (context, state) {
                    final images = state.details.imagesDocUrl ?? [];

                    return CustomAddImage(
                      images: images,
                      isLoading: state is AddDocumentImageLoading,
                      onTap: AddPropertyCubit.get(context).addDocumentImage,
                    );
                  },
                  listener: (BuildContext context, AddPropertyState state) {
                    if (state is AddImageError) {
                      SnackBarMessage.call(context, state.message, false);
                    }
                  },
                ),
                const SizedBox(height: 24),
                // ══════════════════════════
                // الحقول المشتركة
                // ══════════════════════════
                SectionTitle(title: AppStrings.sectionBasicInfo),
                PropertyDetailsForm(
                  titleController: _titleController,
                  locationController: _locationController,
                  priceController: _priceController,
                  areaController: _areaController,
                  propertyDetails: _propertyDetails,
                ),

                // ─── للبيع / للإيجار ───

                // ══════════════════════════
                // حقول خاصة بالنوع
                // ══════════════════════════
                BlocBuilder<AddPropertyCubit, AddPropertyState>(
                  builder: (context, state) {
                    if (state.details.propertyType == PropertyType.villa) {
                      return VillaFields();
                    }
                    if (state.details.propertyType == PropertyType.apartment) {
                      return ApartmentFields();
                    }
                    if (state.details.propertyType == PropertyType.land) {
                      return LandFields(
                        streetWidthController: _streetWidthController,
                      );
                    }
                    return SizedBox();
                  },
                ),

                const SizedBox(height: 32),

                // ══════════════════════════
                // زر الحفظ
                // ══════════════════════════
                AddPropertyButton(
                  formKey: _formKey,
                  titleController: _titleController,
                  locationController: _locationController,
                  priceController: _priceController,
                  areaController: _areaController,
                  streetWidthController: _streetWidthController,
                  propertyDetails: _propertyDetails,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddPropertyButton extends StatelessWidget {
  const AddPropertyButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.titleController,
    required this.locationController,
    required this.priceController,
    required this.areaController,
    required this.streetWidthController,
    required this.propertyDetails,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController priceController;
  final TextEditingController areaController;
  final TextEditingController streetWidthController;
  final TextEditingController propertyDetails;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPropertyCubit, AddPropertyState>(
      listener: (context, state) {
        if (state is AddPropertySuccess) {
          SnackBarMessage.call(context, state.message, true);
          Navigator.pop(context);
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              AddPropertyCubit.get(context).addProperty(
                titleController: titleController,
                locationController: locationController,
                priceController: priceController,
                areaController: areaController,
                streetWidthController: streetWidthController,
                propertyDetailsController: propertyDetails,
              );
            }
          },

          child: const Text(
            AppStrings.btnAddProperty,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CustomAddImage extends StatelessWidget {
  const CustomAddImage({
    super.key,
    required this.images,

    this.onTap,
    required this.isLoading,
  });
  final List<String> images;

  final bool isLoading;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // ➕ Add button
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.midnightBlue),
              color: AppColors.buttonBlue.withValues(alpha: .3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add),
          ),
        ),

        // 🖼 images list
        ...List.generate(images.length, (index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              images[index],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          );
        }),

        // ⏳ Loading indicator (optional)
        if (isLoading)
          const SizedBox(
            width: 60,
            height: 60,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
