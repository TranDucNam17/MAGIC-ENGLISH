import 'package:btl_magicenglish/features/auth/presentation/pages/new_password_success_page.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  // State để quản lý việc ẩn/hiện của từng mật khẩu
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Định nghĩa các màu sắc và style để đảm bảo tính nhất quán
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBlueBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);
    const Color greyBorder = Color(0xFFE0E0E0);
    const Color greyIcon = Color(0xFF9E9E9E);

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

                // 5. Header: Tiêu đề màn hình
                const Text(
                  'New Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                // 6. Form: Trường nhập "New password"
                TextFormField(
                  obscureText: !_isNewPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'New password',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock_outline, color: greyIcon),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isNewPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: greyIcon,
                      ),
                      onPressed: () {
                        setState(() {
                          _isNewPasswordVisible = !_isNewPasswordVisible;
                        });
                      },
                    ),
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

                const SizedBox(height: 16),

                // 7. Form: Trường nhập "Confirm a new password"
                TextFormField(
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirm a new password',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock_outline, color: greyIcon),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: greyIcon,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
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

                // 8. Primary Button: Nút "Confirm"
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
                      // TODO:
                      // 1. Kiểm tra xem hai mật khẩu có khớp nhau không.
                      // 2. Gửi mật khẩu mới đến server.
                      // 3. Nếu thành công, điều hướng đến màn hình Login hoặc Home.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPasswordSuccessPage()));
                    },
                    color: primaryBlue,
                    minWidth: double.infinity,
                    shape: const StadiumBorder(),
                    child: const Text(
                      'Confirm',
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
