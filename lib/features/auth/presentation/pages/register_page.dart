import 'package:flutter/material.dart';
import 'package:btl_magicenglish/core/services/auth_service.dart';
import 'package:btl_magicenglish/features/auth/presentation/pages/register_success_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_revalidateConfirmPassword);
  }

  void _revalidateConfirmPassword() {
    if(_confirmPasswordController.text.isNotEmpty) {
      _formKey.currentState?.validate();
    }
  }

  @override
  void dispose() {
    _passwordController.removeListener((_revalidateConfirmPassword));
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ));
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      final result = await AuthService.register(
        email: email,
        password: password,
        displayName: email.split('@')[0],
      );

      if (result['success']) {
        print('Registration successful! Token: ${result['token']}');

        if (mounted) Navigator.of(context).pop();
        if (mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const RegisterSuccessPage()));
        }
      } else {
        if (mounted) Navigator.of(context).pop();
        String errorMessage = 'Registration failed. Please try again.';
        if (result['error'].contains('email-already-in-use') ||
            result['error'].contains('already exists')) {
          errorMessage = 'An account already exists for that email.';
        } else if (result['error'].contains('weak-password')) {
          errorMessage = 'The password provided is too weak.';
        } else if (result['error'].contains('invalid-email')) {
          errorMessage = 'The email address is not valid.';
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) Navigator.of(context).pop();
      print('An unexpected error occurred: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF4A90E2);
    const Color lightBlueBackground = Color(0xFFF3F6FF);
    const Color darkText = Color(0xFF1A252F);

    return Scaffold(
      backgroundColor: lightBlueBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Fill in the details below to start your journey",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null || value.trim().isEmpty){
                        return 'Please enter an email';
                      }
                      final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if(!emailRegex.hasMatch(value)){
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordObscured,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey,),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscured
                            ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,),
                        onPressed: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters long.";
                      }
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return "Passwords must contain uppercase letters.";
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return "The password must contain numbers.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordObscured,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isConfirmPasswordObscured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey),
                        onPressed: () => setState(() => !_isConfirmPasswordObscured),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please confirm your password.';
                      }
                      if(value != _passwordController.text){
                        return 'Password do not match.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Log In',
                            style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold),
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
