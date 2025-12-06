import 'package:btl_magicenglish/features/auth/presentation/pages/verification_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Định nghĩa các màu sắc thương hiệu để đảm bảo tính nhất quán
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBlueBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);
    const Color mediumGrey = Color(0xFF6C757D);
    const Color greyBorder = Color(0xFFE0E0E0);
    const Color greyIcon = Color(0xFF9E9E9E);

    return Scaffold(
      // 1. General: Nền xanh rất nhạt
      backgroundColor: lightBlueBackground,
      appBar: AppBar(
        // Thêm một AppBar đơn giản để có nút quay lại tự động
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        // 2. General: Cho phép cuộn để tránh lỗi tràn màn hình
        child: SingleChildScrollView(
          child: Padding(
            // 3. General: Padding ngang 24dp
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
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

                const SizedBox(height: 24),

                // 5. Header: Tiêu đề màn hình
                const Text(
                  'Forgot Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // 6. Description: Văn bản mô tả ngắn
                const Text(
                  'Enter email address to reset password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: mediumGrey,
                  ),
                ),

                const SizedBox(height: 48),

                // 7. Form: Trường nhập liệu Email
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.email_outlined, color: greyIcon),
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
                      borderSide: const BorderSide(color: primaryBlue),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // 8. Primary Button: Nút "Send"
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
                      // TODO: Xử lý logic gửi email đặt lại mật khẩu
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreen()));
                    },
                    color: primaryBlue,
                    minWidth: double.infinity,
                    shape: const StadiumBorder(),
                    child: const Text(
                      'Send',
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
