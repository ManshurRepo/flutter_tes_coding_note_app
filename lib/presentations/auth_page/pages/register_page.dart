import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jobtest_noteapp/common/components/textfield_widget.dart';
import 'package:flutter_jobtest_noteapp/data/models/request/register_request_model.dart';
import 'package:flutter_jobtest_noteapp/presentations/auth_page/bloc/register/register_bloc.dart';
import 'package:flutter_jobtest_noteapp/presentations/auth_page/pages/login_page.dart';

import '../../../common/components/button_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [

                const SizedBox(height: 70),
                Image.asset(
                  'assets/login_icon.png',
                  scale: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'My Notes',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),

                const Text(
                  'Selamat Datang, Silahkan Login untuk Melanjutkan',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),
                TextfieldWidget(
                  controller: nameController,
                  hintText: "Username",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                TextfieldWidget(
                  controller: emailController,
                  hintText: "email",
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                TextfieldWidget(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 50.0),


                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      succes: (data) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Pendaftaran Berhasil. Silahkan Masukan Akun Anda',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            backgroundColor: Color.fromARGB(255, 152, 252, 156),
                          ),
                        );
                      },
                      error: (message,) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              message,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            backgroundColor: const Color.fromARGB(255, 250, 145, 137),
                          ),
                        );
                      },
                    );
                  },
                  builder: (context, state) {

                    bool isLoading = state.maybeWhen(
                      orElse: () => false,
                      loading: () => true,
                    );



                    return isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.deepOrangeAccent,
                          ))
                        : RegisterButton(
                            onTap: () {
                              final data = RegisterRequestModel(
                                name: nameController.text,
                                password: passwordController.text,
                                email: emailController.text,
                                username: nameController.text.replaceAll('', ''),);
                              context
                                  .read<RegisterBloc>()
                                  .add(RegisterEvent.register(data));
                            },
                          );
                  },















                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
