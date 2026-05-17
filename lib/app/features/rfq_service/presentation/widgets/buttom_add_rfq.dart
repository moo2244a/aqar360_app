import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/usecases/snak_bar_message.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';
import 'package:aqar360/app/features/rfq_service/presentation/cubit/rfq_cubit.dart';
import 'package:aqar360/app/features/rfq_service/presentation/cubit/rfq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtomAddRfq extends StatelessWidget {
  const ButtomAddRfq({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.companyModel,
    required TextEditingController titleController,
    required TextEditingController descController,
  }) : _formKey = formKey,
       _titleController = titleController,
       _descController = descController;

  final GlobalKey<FormState> _formKey;
  final UserModel companyModel;
  final TextEditingController _titleController;
  final TextEditingController _descController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final newRfq = RfqModel(
              id: '',
              companyId: companyModel.id!,
              companyName: companyModel.name!,

              projectTitle: _titleController.text.trim(),
              details: _descController.text.trim(),
              createdAt: DateTime.now(),
            );
            await RfqCubit.get(context).sendRfq(newRfq);
          }
        },
        child: BlocConsumer<RfqCubit, RfqState>(
          listener: (context, state) {
            if (state is RfqSuccess) {
              SnackBarMessage.call(context, state.message, true);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is RfqLoading) {
              return const CircularProgressIndicator(color: Colors.white);
            } else {
              return Text(
                AppStrings.submitRequestText,
                style: Theme.of(context).textTheme.titleLarge,
              );
            }
          },
        ),
      ),
    );
  }
}
