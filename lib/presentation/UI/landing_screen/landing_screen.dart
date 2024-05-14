import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/presentation/UI/auth_screen/login_screen.dart';
import 'package:todoapp/presentation/widgets/custom_background.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        imgAdress: 'assets/images/landing.png',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/smalllogo.svg'),
                const Gap(8),
                const Text(
                  'Manage Tasks',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Gap(10),
            const Text(
              textAlign: TextAlign.center,
              'Innovative, user-friendly,\n and easy',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic),
            ),
            const Gap(12),
            InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen())),
                child: getStartedButton()),
          ],
        ),
      ),
    );
  }
}

Widget getStartedButton() {
  return Container(
    height: 45,
    width: 150,
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: const Color(0xFF757575),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Get started',
          style: TextStyle(fontSize: 13),
        ),
        Gap(6),
        Icon(
          Icons.arrow_forward,
          size: 15,
        ),
      ],
    ),
  );
}
