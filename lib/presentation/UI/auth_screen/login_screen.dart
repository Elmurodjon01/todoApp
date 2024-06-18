import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/bloc/authentication/auth_bloc.dart';
import 'package:todoapp/bloc/authentication/auth_event.dart';
import 'package:todoapp/bloc/authentication/auth_state.dart';
import 'package:todoapp/data/model/user/user_model.dart';
import 'package:todoapp/presentation/UI/auth_screen/custom_button.dart';
import 'package:todoapp/presentation/UI/auth_screen/signup_screen.dart';
import 'package:todoapp/presentation/UI/home_screen/home_screen.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';
import 'package:todoapp/presentation/widgets/toast.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBackground(
        imgAdress: 'assets/images/login_background.png',
        child: BlocConsumer<AuthBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthError) {
              Toast().showToast(state.message, context);
            }
            if (state is AuthAuthenticated) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                if (state is AuthLoading)
                  const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: const Color(0xFF757575),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'email@remote.com',
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: const Color(0xFF757575),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'password',
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          AuthButton(
                            ontap: () {
                              UserModel user = UserModel(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  username: 'dddd');
                              BlocProvider.of<AuthBloc>(context)
                                  .add(AuthLoggedIn(
                                user: user,
                              ));
                            },
                            title: 'Login',
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const Gap(5),
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen())),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
