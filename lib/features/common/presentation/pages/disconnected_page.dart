import 'package:flutter/material.dart';
class DisconnectedPage extends StatelessWidget {
  final VoidCallback onRetry;

  const DisconnectedPage({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF3B82F6);
    const Color lightBackground = Color(0xFFF3F5F9);
    const Color darkText = Color(0xFF1A252F);
    const Color greyText = Color(0xFF5A6B7B);

    return Scaffold(
      backgroundColor: lightBackground,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.wifi_off_rounded,
                    size: 100,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'No Internet Connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: darkText,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Please check your internet connection and try again. Magic English needs the internet to work its magic!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: greyText,
                      fontFamily: 'Roboto',
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), //
                      ),
                      elevation: 4,
                      shadowColor: primaryBlue.withOpacity(0.4),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
