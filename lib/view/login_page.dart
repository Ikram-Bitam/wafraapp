import 'package:flutter/material.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background with blur effect
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          // Content - Single Frame Layout
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40), // Reduced from 60

                      // App Logo
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 60, // Increased from 60
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.orange,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10), // Further reduced spacing

                      // Tagline
                      const Text(
                        "From What We Have, To Who Needs It Most",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 30), // Reduced space before image

                      // Image container - Made larger
                      Container(
                        height: 260, // Increased from 200
                        width: double.infinity,
                        child: Builder(
                          builder: (context) {
                            try {
                              return Image.asset(
                                'assets/images/signup.png',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Image error: $error');
                                  return Container(
                                    color: Colors.grey.withOpacity(0.1),
                                    child: const Icon(
                                      Icons.image,
                                      size: 80,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              );
                            } catch (e) {
                              print('Widget error: $e');
                              return Container(
                                color: Colors.grey.withOpacity(0.1),
                                child: const Icon(
                                  Icons.image,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                              );
                            }
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Descriptive text
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          "Connect with organizations and businesses to rescue surplus food, reduce waste, and make a positive environmental impact while saving money.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Error message if any
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                      // Social login buttons
                      // Google button
                      _buildSocialButton(
                        text: "Continue with Google",
                        icon: Image.asset(
                          'assets/images/google.webp',
                          width: 24,
                          height: 24,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.g_mobiledata, size: 24);
                          },
                        ),
                        borderColor: Colors.grey.withOpacity(0.3),
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onPressed: () => _handleSocialLogin("Google"),
                      ),

                      const SizedBox(height: 18),

                      // Apple button
                      _buildSocialButton(
                        text: "Continue with Apple",
                        icon: const Icon(Icons.apple,
                            color: Colors.white, size: 24),
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        onPressed: () => _handleSocialLogin("Apple"),
                      ),

                      const SizedBox(height: 18),

                      // Facebook button
                      _buildSocialButton(
                        text: "Continue with Facebook",
                        icon: const Icon(Icons.facebook,
                            color: Colors.white, size: 24),
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () => _handleSocialLogin("Facebook"),
                      ),

                      const SizedBox(height: 18),

                      // "Autres" text with no underline
                      const Text(
                        "Autres",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 15),
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
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 1,
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
                fontSize: 15,
                color: textColor,
                fontWeight: FontWeight.w500,
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
        if (mounted) {
          Navigator.of(context).pushNamed('/user');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully logged in with $provider')),
          );
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
}
