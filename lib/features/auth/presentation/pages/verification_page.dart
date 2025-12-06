import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //
import 'package:btl_magicenglish/features/auth/presentation/pages/new_password_page.dart';// Để sử dụng InputFormatter

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Định nghĩa các màu sắc và style để đảm bảo tính nhất quán
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBlueBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);
    const Color mediumGrey = Color(0xFF6C757D);
    const Color greyBorder = Color(0xFFE0E0E0);

    return Scaffold(
      // 1. General: Nền xanh rất nhạt
      backgroundColor: lightBlueBackground,
      appBar: AppBar(
        // AppBar để cung cấp nút quay lại tự động
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        // 2. General: Cho phép cuộn khi bàn phím hiện lên
        child: SingleChildScrollView(
          child: Padding(
            // 3. General: Padding ngang 24dp
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              // Căn lề trái cho các phần tử bên trong Column
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),

                // 4. Header: Tên ứng dụng
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 32,
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
                const SizedBox(height: 48),

                // 5. Title: Tiêu đề màn hình
                const Text(
                  'Enter verification code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // 6. Description: Văn bản mô tả
                const Text(
                  'We just sent a 6-digit code to your email. Please check it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: mediumGrey,
                  ),
                ),
                const SizedBox(height: 40),

                // 7. Verification Code Field: Nhãn căn lề trái
                const Text(
                  'Verification code',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600, // Medium-bold
                    color: mediumGrey,
                  ),
                ),
                const SizedBox(height: 8),

                // 8. Verification Code Field: Trường nhập liệu
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center, // Căn giữa chữ trong ô input
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8, // Tạo khoảng cách giữa các số
                  ),
                  decoration: InputDecoration(
                    counterText: "", // Ẩn bộ đếm ký tự
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: greyBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: greyBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: primaryBlue, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 9. Primary Button: Nút "Verify"
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), // Hình dạng viên thuốc
                    boxShadow: [
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      // TODO: Xử lý logic xác thực mã code
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewPasswordScreen(),
                        ),
                      );
                    },
                    color: primaryBlue,
                    minWidth: double.infinity,
                    shape: const StadiumBorder(),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
