import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        imgAdress: 'assets/images/login_background.png',
        child: Column(
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '     email@provider.com',
                      ),
                      validator: (value) {},
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '     password',
                      ),
                      validator: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
