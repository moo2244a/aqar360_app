import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';
import 'package:aqar360/app/features/rfq_service/domain/usecases/send_rfq_use_case.dart';
import 'package:aqar360/app/features/rfq_service/presentation/cubit/rfq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RfqCubit extends Cubit<RfqState> {
  RfqCubit(this.sendRfqUseCase) : super(RfqInitial());
  final SendRfqUseCase sendRfqUseCase;
  static RfqCubit get(BuildContext context) =>
      BlocProvider.of<RfqCubit>(context);
  Future<void> sendRfq(RfqModel newRfq) async {
    emit(RfqLoading());
    final result = await sendRfqUseCase(newRfq);

    if (isClosed) return;

    result.fold(
      (ifLeft) {
        emit(RfqError(ifLeft.message));
      },
      (ifRight) {
        emit(RfqSuccess(" تم تقديم الطلب بنجاح!"));
      },
    );
  }
}
