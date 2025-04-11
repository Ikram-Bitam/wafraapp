import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Type Selector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: const UserTypeScreen(),
    );
  }
}

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  void _navigateTo(BuildContext context, String userType) {
    print("$userType selected");
    Navigator.pushNamed(context, '/explore', arguments: userType);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text("Navigating to $userType")),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Back",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Later",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Updated App Logo
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

            const SizedBox(height: 40),

            const Text(
              "(business, charity, or individual)",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "To better serve your needs, could you please specify your account type?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 40),

            _buildOptionCard(
              title: "Business/Organization",
              description:
                  "(For companies, institutions, or commercial entities managing transactions, teams, or services.)",
              onTap: () => _navigateTo(context, "Business/Organization"),
            ),

            const SizedBox(height: 20),

            _buildOptionCard(
              title: "Charity Society",
              description:
                  "(For registered NGOs, foundations, or charitable organizations with tax-exempt status.)",
              onTap: () => _navigateTo(context, "Charity Society"),
            ),

            const SizedBox(height: 20),

            _buildOptionCard(
              title: "Individual User",
              description:
                  "(For personal use, non-commercial transactions, or individual accounts.)",
              onTap: () => _navigateTo(context, "Individual User"),
            ),

            const SizedBox(height: 40),
          ],
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

  Widget _buildOptionCard({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
