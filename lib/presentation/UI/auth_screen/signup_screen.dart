import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:todoapp/model/user/user_model.dart';
import 'package:todoapp/presentation/UI/auth_screen/custom_button.dart';
import 'package:todoapp/presentation/UI/auth_screen/login_screen.dart';
import 'package:todoapp/presentation/UI/mainScreen.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';
import 'package:todoapp/presentation/widgets/toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // BlocBuilder<AuthBloc, AuthBlocState>(
              //   builder: (context, state) {
              //     if (state is AuthFailure) {
              //       return Center(
              //         child: Text(state.error),
              //       );
              //     }
              //     if (state is AuthLoading) {
              //       if (state.isLoading == true) {
              //         return const Center(
              //           child: CircularProgressIndicator.adaptive(),
              //         );
              //       } else {
              //         return const SizedBox.shrink();
              //       }
              //     }
              //     if (state is AuthSignedIn) {
              //       print('state status ${state.userToken}');
              //       WidgetsBinding.instance.addPostFrameCallback((_) {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) =>
              //                   HomeScreen(userToken: state.userToken)),
              //         );
              //       });
              //     }
              //     return Form(
              //       child: Column(
              //         children: [
              //           Container(
              //             height: 50,
              //             margin: const EdgeInsets.symmetric(horizontal: 30),
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 width: 1,
              //                 color: const Color(0xFF757575),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 10),
              //               child: TextFormField(
              //                 controller: usernameController,
              //                 decoration: const InputDecoration(
              //                   border: InputBorder.none,
              //                   hintText: 'username',
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const Gap(10),
              //           Container(
              //             height: 50,
              //             margin: const EdgeInsets.symmetric(horizontal: 30),
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 width: 1,
              //                 color: const Color(0xFF757575),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 10),
              //               child: TextFormField(
              //                 controller: emailController,
              //                 decoration: const InputDecoration(
              //                   border: InputBorder.none,
              //                   hintText: 'email@provider.com',
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const Gap(10),
              //           Container(
              //             height: 50,
              //             margin: const EdgeInsets.symmetric(horizontal: 30),
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 width: 1,
              //                 color: const Color(0xFF757575),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 10),
              //               child: TextFormField(
              //                 controller: passwordController,
              //                 decoration: const InputDecoration(
              //                   border: InputBorder.none,
              //                   hintText: 'password',
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const Gap(10),
              //           AuthButton(
              //             ontap: () {
              //               context.read<AuthBloc>().add(
              //                     SignInEvent(
              //                       UserModel(
              //                         email: emailController.text.trim(),
              //                         password: passwordController.text.trim(),
              //                         username: usernameController.text.trim(),
              //                       ),
              //                     ),
              //                   );
              //             },
              //             title: 'Sign Up',
              //           ),
              //           const Gap(20),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               const Text(
              //                 "Already have an account?",
              //                 style: TextStyle(
              //                   fontSize: 13,
              //                   fontWeight: FontWeight.w300,
              //                 ),
              //               ),
              //               const Gap(5),
              //               InkWell(
              //                 onTap: () => Navigator.of(context).pop(
              //                     MaterialPageRoute(
              //                         builder: (context) =>
              //                             const LoginScreen())),
              //                 child: const Text(
              //                   'Log In',
              //                   style: TextStyle(
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.bold,
              //                     decoration: TextDecoration.underline,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
          
            ],
          ),
          imgAdress: 'assets/images/signup_back.png'),
    );
  }
}
