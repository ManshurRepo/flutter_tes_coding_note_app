import 'package:flutter/material.dart';
import 'package:flutter_jobtest_noteapp/presentations/auth_page/bloc/register/register_bloc.dart';
import 'package:flutter_jobtest_noteapp/presentations/auth_page/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentations/auth_page/bloc/login/login_bloc.dart';
import 'presentations/fitur_page.dart/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/HomePage': (context) => const HomePage(),
        },

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
