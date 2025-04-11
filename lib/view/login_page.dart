import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wafra App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background with blur effect
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),

                      // App Logo
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 60,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.orange,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Tagline
                      Text(
                        "Together, let's start saving\nfamilies !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),

                      // Large blank space for possible future image
                      const SizedBox(height: 120),
                      Container(
                        height: 200,
                        // Temporary background to verify container visibility
                        child: Builder(
                          builder: (context) {
                            try {
                              return Image.asset(
                                'assets/images/signup.png',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Image error: $error');
                                  return Container(
                                    color: Colors.yellow,
                                    child: const Icon(Icons.error),
                                  );
                                },
                              );
                            } catch (e) {
                              print('Widget error: $e');
                              return Container(
                                color: Colors.blue,
                                child: const Icon(Icons.warning),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Connect with organizations and businesses to rescue surplus food, reduce waste, and make a positive environmental impact while saving money.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.5)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.red.withOpacity(0.5)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.red.withOpacity(0.5)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.5)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.red.withOpacity(0.5)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.red.withOpacity(0.5)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 8),

                      // Error message if any
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Social login buttons
                      // Google button
                      _buildSocialButton(
                        text: "Continue with Google",
                        icon: Image.asset(
                          'assets/images/google.webp',
                          width: 2,
                          height: 2,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                                Icons.error); // Fallback if image fails to load
                          },
                        ),
                        borderColor: Colors.grey.withOpacity(0.3),
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onPressed: () => _handleSocialLogin("Google"),
                      ),

                      const SizedBox(height: 12),

                      // Apple button
                      _buildSocialButton(
                        text: "Continue with Apple",
                        icon: const Icon(Icons.apple, color: Colors.white),
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        onPressed: () => _handleSocialLogin("Apple"),
                      ),

                      const SizedBox(height: 12),

                      // Facebook button
                      _buildSocialButton(
                        text: "Continue with Facebook",
                        icon: const Icon(Icons.facebook, color: Colors.white),
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () => _handleSocialLogin("Facebook"),
                      ),

                      const SizedBox(height: 40),

                      // Bottom indicator
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required Widget icon,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
    Color? borderColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: borderColor != null
                ? BorderSide(color: borderColor)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSocialLogin(String provider) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      // Mock authentication logic
      if (provider == "Facebook") {
        // Example of handling a specific error
        setState(() {
          _errorMessage = "Facebook login is temporarily unavailable";
        });
      } else {
        // Handle successful login
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully logged in with $provider')),
          );
          // Navigate to home page or next screen
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(builder: (context) => HomePage()),
          // );
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
