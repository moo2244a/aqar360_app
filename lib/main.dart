import 'package:aqar360/app/app_root.dart';
import 'package:aqar360/app/core/usecases/auth_dependencies.dart';
import 'package:aqar360/app/features/login/presentation/cubit/logic_in_login/login_cubit.dart';

import 'package:aqar360/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final authDependencies = AuthDependencies.create();
            return LoginCubit(loginUsecase: authDependencies.loginUsecase);
          },
        ),
      ],
      child: const AppRoot(),
    ),
  );
}
