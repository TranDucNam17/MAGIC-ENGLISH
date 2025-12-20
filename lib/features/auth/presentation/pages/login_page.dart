import 'package:btl_magicenglish/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:btl_magicenglish/features/auth/presentation/pages/register_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/home_dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if(!_formKey.currentState!.validate()){
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try{
      print('Attempting to sign in with Firebase Auth...');
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      final user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        print('Firebase Auth: User signed in successfully! UID: ${user.uid}');
        final idToken = await user.getIdToken(true);
        if(idToken != null) {
          await Clipboard.setData(ClipboardData(text: idToken));
          print('----------- FIREBASE ID TOKEN -----------');
          print('USER: ${user.email}');
          print('ID Token has been copied to clipboard!');
          print('-----------------------------------------');
          if(mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Firebase ID Token copied to clipboard!'),
                  backgroundColor: Colors.green,
                  // duration: Duration(seconds: 3),
                )
            );
          }
        }else {
          print('Error: Could not retrieve ID Token even though user exists.');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error: Could not retrieve ID Token.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
      else {
        print('Error: User not found despite successful login attempt.');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed: User object not found.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
      if(mounted) Navigator.of(context).pop();
      if(mounted && user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeDashboardScreen()),
              (Route<dynamic> route) => false,
        );
      }
    }on FirebaseAuthException catch (e) {
      if(mounted) Navigator.of(context).pop();
      print('Firebase Auth Error: ${e.code}');
      String errorMessage = 'An error occurred. Please try again.';
      if(e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        errorMessage = 'Invalid email or password. Please try again.';
      }else if(e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }catch (e) {
      if(mounted) Navigator.of(context).pop();
      print('An unexpected error occurred: $e');
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An unexpected error occurred. Please check your network connection.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color darkText = Color(0xFF1A252F);
    const Color greyBorder = Color(0xFFE0E0E0);
    const Color greyIcon = Color(0xFF9E9E9E);

    return Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(

                key: _formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Roboto', fontSize: 32, fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(text: 'MAGIC ', style: TextStyle(color: primaryBlue)),
                          TextSpan(text: 'ENGLISH', style: TextStyle(color: darkText)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Log In',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: primaryBlue, fontSize: 22, fontWeight: FontWeight.bold,),
                    ),
                    const SizedBox(height: 48),

                    TextFormField(
                      controller: _emailController,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if(value == null || value.trim().isEmpty){
                          return 'Please enter your email.';
                        }
                        final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if(!emailRegex.hasMatch(value)){
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your password';
                        }
                        if(value.length < 6){
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: primaryBlue, fontSize: 14),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: primaryBlue, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 56,
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
                        gradient: const LinearGradient(
                          colors: [primaryBlue, Color(0xFF1976D2)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: _handleLogin,
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
        )
    );
  }
}