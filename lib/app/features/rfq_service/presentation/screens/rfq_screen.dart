import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/utils/app_validators.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/login/presentation/widgets/custom_auth_text_field.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_dependencies.dart';
import 'package:aqar360/app/features/rfq_service/presentation/cubit/rfq_cubit.dart';

import 'package:aqar360/app/features/rfq_service/presentation/widgets/buttom_add_rfq.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RfqScreen extends StatefulWidget {
  final UserModel companyModel;

  const RfqScreen({super.key, required this.companyModel});

  @override
  State<RfqScreen> createState() => _RfqScreenState();
}

class _RfqScreenState extends State<RfqScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RfqCubit>(
      create: (_) {
        final RfqDependencies dependencies = RfqDependencies.create();
        return RfqCubit(dependencies.sendRfqUseCase);
      },

      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'طلب ل${widget.companyModel.name!}',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      hint: AppStrings.projectTitleHint,
                      label: AppStrings.projectTitleLabel,
                      labelColor: Theme.of(context).colorScheme.onSurface,
                      validator: (value) => AppValidators.requiredField(
                        value,
                        AppStrings.projectTitleLabel,
                      ),
                      controller: _titleController,
                    ),

                    const SizedBox(height: 24),
                    CustomTextField(
                      hint: AppStrings.projectDescHint,
                      label: AppStrings.projectDescLabel,
                      maxLength: 500,
                      maxLines: 5,
                      labelColor: Theme.of(context).colorScheme.onSurface,
                      validator: (value) => AppValidators.requiredField(
                        value,
                        AppStrings.projectDescLabel,
                      ),
                      controller: _descController,
                    ),

                    const SizedBox(height: 32),
                    ButtomAddRfq(
                      formKey: _formKey,
                      companyModel: widget.companyModel,
                      titleController: _titleController,
                      descController: _descController,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
