import 'package:flutter/material.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({super.key});

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  int _selectedIndex = 0;
  // Add a map to track favorite status of items
  Map<String, bool> _favorites = {
    'vegetables': false,
    'pastries': false,
    'furniture': false,
    'fruits': false,
    'electronics': false,
    'offer1': true,
    'offer2': true,
    'offer3': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildMap(),
            _buildFilterSection(),
            Expanded(
              child: _buildContentSection(),
            ),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo in orange
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 30,
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
          // Notification bell
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_outlined, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // My location text with icon
          Row(
            children: [
              Text(
                "My location",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.location_on,
                color: Colors.orange,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Map container
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/map.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Fallback if map image fails to load
                Center(
                  child: Text(
                    "Batna",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Markers can be added here
                Positioned(
                  right: 80,
                  bottom: 70,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child:
                        Icon(Icons.location_on, color: Colors.white, size: 16),
                  ),
                ),
                Positioned(
                  left: 70,
                  bottom: 80,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child:
                        Icon(Icons.restaurant, color: Colors.orange, size: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    List<String> filters = [
      "All",
      "Food",
      "Furniture",
      "Electronics",
      "Clothing",
      "Groceries",
      "Home",
      "Beauty"
    ];

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0; // Default to "All" selected
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  filters[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentSection() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        _buildSectionHeader("Recommended for you"),
        _buildRecommendedItems(),
        _buildSectionHeader("Special Offers"),
        _buildSpecialOffers(),
        // Add more sections as needed
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "See all",
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedItems() {
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildRecommendedItemCard(
            'Fresh Vegetables',
            'assets/images/vegetables.jpg',
            'vegetables',
          ),
          _buildRecommendedItemCard(
            'Pastries & Cakes',
            'assets/images/pastries.jpg',
            'pastries',
            distance: '0.6 km away',
            discountedPrice: '80 DA',
            originalPrice: '200 DA',
          ),
          _buildRecommendedItemCard(
            'Furniture',
            'assets/images/furniture.jpg',
            'furniture',
            distance: '2 km away',
            discountedPrice: 'FREE',
            originalPrice: '200 DA',
          ),
          _buildRecommendedItemCard(
            'Fresh Fruits',
            'assets/images/fruits.jpg',
            'fruits',
            distance: '0.3 km away',
            discountedPrice: '2000 DA',
            originalPrice: '500 DA',
          ),
          _buildRecommendedItemCard(
            'Electronics',
            'assets/images/electronics.jpg',
            'electronics',
            distance: '3 km away',
            discountedPrice: '700 DA',
            originalPrice: '200 DA',
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedItemCard(
    String title,
    String imagePath,
    String id, {
    String distance = '1 km away',
    String discountedPrice = '220 DA',
    String originalPrice = '500 DA',
  }) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 15.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item image with favorite button
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: 180,
              width: double.infinity,
              color: Colors.grey[300],
              child: Stack(
                children: [
                  // Placeholder for image
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
                  // Favorite button with tap functionality
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        // Toggle favorite state
                        setState(() {
                          _favorites[id] = !(_favorites[id] ?? false);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _favorites[id] ?? false
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Item info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      discountedPrice,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      originalPrice,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialOffers() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSpecialOfferCard(
            'Monthly Special Offer',
            '70% OFF',
            "Don't miss out on incredible savings for fresh, high-quality produce! Limited time only!",
            'offer1',
          ),
          _buildSpecialOfferCard(
            'Weekend Special Offer',
            '50% OFF',
            "Get amazing discounts on fresh produce!",
            'offer2',
          ),
          _buildSpecialOfferCard(
            'Ramadan Special Offer',
            'Free',
            "Celebrate Ramadan with savings! Discounts on farm-fresh produce to fill your table with barakah.",
            'offer3',
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialOfferCard(
    String title,
    String discount,
    String description,
    String id,
  ) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/special_offer.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    discount,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          // Favorite button with toggling functionality
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _favorites[id] = !(_favorites[id] ?? false);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _favorites[id] ?? false ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    List<Map<String, dynamic>> navItems = [
      {'icon': Icons.explore, 'label': 'Discover'},
      {'icon': Icons.search, 'label': 'Explore'},
      {'icon': Icons.add_circle_outline, 'label': 'Create'},
      {'icon': Icons.chat_bubble_outline, 'label': 'Messages'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          return InkWell(
            onTap: () {
              if (index == 2) {
                // Index 2 is for "Create"
                _showCreateOptions(context);
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  navItems[index]['icon'],
                  color: _selectedIndex == index ? Colors.orange : Colors.grey,
                ),
                const SizedBox(height: 4),
                Text(
                  navItems[index]['label'],
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        _selectedIndex == index ? Colors.orange : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _showCreateOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Center(
                    child: Text(
                      'Offer',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle donation action
                  },
                ),
                Divider(height: 0, thickness: 1),
                ListTile(
                  title: Center(
                    child: Text(
                      'Donate',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/offer');
                    // Handle donation action
                  },
                ),
                Divider(height: 0, thickness: 1),
                ListTile(
                  title: Center(
                    child: Text(
                      'Request',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle request action
                  },
                ),
                Divider(height: 0, thickness: 1),
                ListTile(
                  title: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
