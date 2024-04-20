import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jobtest_noteapp/data/models/request/login_request_model.dart';
import 'package:flutter_jobtest_noteapp/presentations/auth_page/pages/register_page.dart';
import 'package:flutter_jobtest_noteapp/presentations/fitur_page.dart/homepage.dart';
import '../../../common/components/button_widget.dart';
import '../../../common/components/textfield_widget.dart';
import '../bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
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

                const SizedBox(height: 90),
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
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),


                const SizedBox(
                  height: 10,
                ),
                TextfieldWidget(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Lupa Password?'),
                    ],
                  ),
                ),
                const SizedBox(height: 35.0),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      succes: (data) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Login Berhasil',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            backgroundColor: Color.fromARGB(255, 152, 252, 156),
                          ),
                        );
                      },
                      error: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              error,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            backgroundColor: Colors.red,
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
                        : LoginButton(
                            onTap: () {
                              final data = LoginRequestModel(
                                  identifier: emailController.text,
                                  password: passwordController.text);
                              context
                                  .read<LoginBloc>()
                                  .add(LoginEvent.login(data));
                            },
                          );
                  },
                ),

                const SizedBox(height: 25),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Belum punya akun? ",
                        children: [
                          TextSpan(
                            text: "Daftar",
                            style: TextStyle(
                                color: Color.fromARGB(255, 49, 103, 146)),
                          ),
                        ],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
