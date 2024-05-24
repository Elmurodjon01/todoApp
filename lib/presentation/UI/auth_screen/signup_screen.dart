import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:todoapp/bloc/auth_bloc/auth_event.dart';
import 'package:todoapp/bloc/auth_bloc/auth_state.dart';
import 'package:todoapp/model/user/user_model.dart';
import 'package:todoapp/presentation/UI/auth_screen/custom_button.dart';
import 'package:todoapp/presentation/UI/auth_screen/login_screen.dart';
import 'package:todoapp/presentation/UI/home_screen/home_screen.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';
import 'package:todoapp/presentation/widgets/toast.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final usernameController = useTextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<AuthBloc, AuthBlocState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    Toast().showToast(state.message, context);
                  }
                  if (state is AuthAuthenticated) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
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
                      Form(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'username',
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                                    hintText: 'email@provider.com',
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                                  obscureText: true,
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
                                context.read<AuthBloc>().add(
                                      AuthSignUp(
                                        UserModel(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          username:
                                              usernameController.text.trim(),
                                        ),
                                      ),
                                    );
                              },
                              title: 'Sign Up',
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const Gap(5),
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen())),
                                  child: const Text(
                                    'Log In',
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
                  );
                },
              )
            ],
          ),
          imgAdress: 'assets/images/signup_back.png'),
    );
  }
}
