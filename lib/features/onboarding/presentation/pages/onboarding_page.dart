import 'package:flutter/material.dart';
import 'package:btl_magicenglish/features/auth/presentation/pages/login_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color almostWhite = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);
    const Color mediumGrey = Color(0xFF6C757D);

    return Scaffold(
      backgroundColor: almostWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: HeroSection(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                child: PrimaryButton(
                  text: 'Start',
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color darkText = Color(0xFF1A252F);
    const Color mediumGrey = Color(0xFF6C757D);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/onboarding_hero.png',
          height: 250,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 250,
              width: 250,
              color: Colors.grey[300],
              child: const Icon(Icons.school, size: 100, color: Colors.grey),
            );
          },
        ),

        const SizedBox(height: 48),

        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'MAGIC ',
                style: TextStyle(color: primaryBlue),
              ),
              TextSpan(
                text: 'ENGLISH',
                style: TextStyle(color: darkText),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Learn English — smarter, faster, your way',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: mediumGrey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(100),
      ),
      height: 56,
      child: MaterialButton(
        onPressed: onPressed,
        color: primaryBlue,
        minWidth: double.infinity,
        shape: const StadiumBorder(),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
