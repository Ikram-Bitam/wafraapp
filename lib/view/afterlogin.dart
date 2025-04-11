import 'package:flutter/material.dart';

class AfterLoginScreen extends StatelessWidget {
  const AfterLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Back",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Later",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Logo PNG or fallback box
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    print('Logo error: $error');
                    return Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.image_not_supported, color: Colors.orange),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              // Main question
              const Text(
                "What do you want to do ?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              Container(
                width: 120,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Whatever your answer, you'll have access to all the features.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 40),

              _buildOptionCard(
                title: "Give",
                description: "I want to empty my cupboards quickly and easily.",
                onTap: () {
                  print("Give option selected");
                },
              ),

              const SizedBox(height: 20),

              _buildOptionCard(
                title: "Collect",
                description: "I want to collect items around me for free.",
                onTap: () {
                  print("Collect option selected");
                },
              ),

              const SizedBox(height: 20),

              _buildOptionCard(
                title: "Both",
                description: "I want to donate and collect items.",
                onTap: () {
                  print("Both option selected");
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 30,
        alignment: Alignment.center,
        child: Container(
          width: 100,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
      ),
    );
  }

  static Widget _buildOptionCard({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

// Run this screen directly
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AfterLoginScreen(),
  ));
}
