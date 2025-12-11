// lib/presentation/auth/register_success_page.dart

import 'package:flutter/material.dart';
import 'package:btl_magicenglish/features/auth/presentation/pages/login_page.dart';

class NewPasswordSuccessPage extends StatelessWidget {
  const NewPasswordSuccessPage({super.key});

  // Hàm xử lý khi người dùng nhấn nút "Confirm"
  void _onConfirmPressed(BuildContext context) {
    // Điều hướng thay thế (pushReplacement) đến màn hình Login.
    // Điều này ngăn người dùng quay lại màn hình đăng ký thành công.
    // Hoặc bạn có thể điều hướng thẳng đến HomeDashboard nếu muốn tự động đăng nhập.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Định nghĩa các màu sắc và style để dễ quản lý
    const Color primaryBlue = Color(0xFF4A90E2);
    const Color lightBlueBackground = Color(0xFFF3F6FF);

    return Scaffold(
      backgroundColor: lightBlueBackground,
      body: SafeArea(
        child: Center(
          // Center để căn giữa nội dung
          child: ConstrainedBox(
            // Giới hạn chiều rộng tối đa để trông đẹp trên web/tablet
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Tiêu đề "Register Success"
                  const Text(
                    "New Password Success",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.w600, // Semi-bold
                      fontFamily: 'Roboto', // hoặc 'Inter'
                    ),
                  ),

                  // 2. Khoảng trống dọc
                  const SizedBox(height: 24),

                  // 3. Nút "Confirm"
                  ElevatedButton(
                    onPressed: () => _onConfirmPressed(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue, // Màu nền chính
                      foregroundColor: Colors.white, // Màu chữ
                      minimumSize: const Size(double.infinity, 52), // Chiều cao
                      shape: const StadiumBorder(), // Bo tròn dạng viên thuốc
                      elevation: 4, // Đổ bóng
                      shadowColor: primaryBlue.withOpacity(0.4),
                    ),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600, // Semi-bold
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
