import 'package:btl_magicenglish/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:btl_magicenglish/features/auth/presentation/pages/register_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/home_dashboard_page.dart';

import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Định nghĩa các màu sắc và style để sử dụng nhất quán
    const Color primaryBlue = Color(0xFF0D47A1); // Màu xanh dương chính
    const Color lightBlueBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);
    const Color greyBorder = Color(0xFFE0E0E0);
    const Color greyIcon = Color(0xFF9E9E9E);

    return Scaffold(
      // 1. Layout: Nền xanh rất nhạt
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        // 2. Layout: Cho phép cuộn khi bàn phím hiện lên
        child: SingleChildScrollView(
          child: Padding(
            // 3. Layout: Padding ngang 24px
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60), // Khoảng trống ở trên cùng

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

                const SizedBox(height: 16),

                // 5. Header: Tiêu đề màn hình "Log In"
                const Text(
                  'Log In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 48), // Khoảng trống lớn trước form

                // 6. Form: Trường nhập Email
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
                  ),
                ),

                const SizedBox(height: 16),

                // 7. Form: Trường nhập Password
                TextFormField(
                  obscureText: !_isPasswordVisible, // Ẩn/hiện mật khẩu
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock_outline, color: greyIcon),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: greyIcon,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
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
                  ),
                ),

                const SizedBox(height: 20),

                // 8. Links Row: Hàng chứa link "Register" và "Forgot password?"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // TODO: Điều hướng đến màn hình đăng ký
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: primaryBlue, fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Điều hướng đến màn hình quên mật khẩu
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: primaryBlue, fontSize: 14),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40), // Khoảng trống lớn trước nút chính

                // 9. Primary Button: Nút "Login"
                Container(
                  height: 56, // Chiều cao nút
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    // Tùy chọn: Sử dụng gradient để làm đẹp hơn
                    gradient: const LinearGradient(
                      colors: [primaryBlue, Color(0xFF1976D2)], // Xanh đậm đến xanh sáng hơn
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      // TODO: Xử lý logic đăng nhập
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeDashboardScreen()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'LOGIN',
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
