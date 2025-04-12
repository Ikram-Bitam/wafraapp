import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Add this import

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

  // Add image data for items
  final Map<String, Map<String, String>> _itemData = {
    'vegetables': {
      'title': 'Fresh Vegetables',
      'image': 'assets/images/vegetables.jpg',
      'distance': '0.5 km away',
      'discountedPrice': '180 DA',
      'originalPrice': '300 DA',
    },
    'pastries': {
      'title': 'Pastries & Cakes',
      'image': 'assets/images/cake.jpg',
      'distance': '0.6 km away',
      'discountedPrice': '80 DA',
      'originalPrice': '200 DA',
    },
    'furniture': {
      'title': 'Furniture',
      'image': 'assets/images/furniture.jpg',
      'distance': '2 km away',
      'discountedPrice': 'FREE',
      'originalPrice': '200 DA',
    },
    'fruits': {
      'title': 'Fresh Fruits',
      'image': 'assets/images/fruits.jpg',
      'distance': '0.3 km away',
      'discountedPrice': '2000 DA',
      'originalPrice': '500 DA',
    },
    'electronics': {
      'title': 'Electronics',
      'image': 'assets/images/electronics.jpg',
      'distance': '3 km away',
      'discountedPrice': '700 DA',
      'originalPrice': '200 DA',
    },
  };

  // Add data for special offers
  final List<Map<String, String>> _specialOffers = [
    {
      'id': 'offer1',
      'title': 'Monthly Special Offer',
      'discount': '70% OFF',
      'description':
          "Don't miss out on incredible savings for fresh, high-quality produce! Limited time only!",
      'image': 'assets/images/monthely-unsplash.jpg',
    },
    {
      'id': 'offer2',
      'title': 'Weekend Special Offer',
      'discount': '50% OFF',
      'description': "Get amazing discounts on fresh produce!",
      'image': 'assets/images/weekendoffer-unsplash.jpg',
    },
    {
      'id': 'offer3',
      'title': 'Ramadan Special Offer',
      'discount': 'Free',
      'description':
          "Celebrate Ramadan with savings! Discounts on farm-fresh produce to fill your table with barakah.",
      'image': 'assets/images/ramadan.jpg',
    },
  ];

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
          // Map container with improved image handling
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // Map image with error handling
                  Image.asset(
                    'assets/images/map.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map, size: 50, color: Colors.grey[400]),
                            Text(
                              "Batna",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
                      child: Icon(Icons.location_on,
                          color: Colors.white, size: 16),
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
                      child: Icon(Icons.restaurant,
                          color: Colors.orange, size: 16),
                    ),
                  ),
                ],
              ),
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
            child: GestureDetector(
              onTap: () {
                // Add filter functionality
                setState(() {
                  _selectedIndex = index;
                });
              },
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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _itemData.length,
        itemBuilder: (context, index) {
          final String key = _itemData.keys.elementAt(index);
          final Map<String, String> data = _itemData[key]!;

          return _buildRecommendedItemCard(
            data['title'] ?? 'Unknown Item',
            data['image'] ?? '',
            key,
            distance: data['distance'] ?? '1 km away',
            discountedPrice: data['discountedPrice'] ?? '0 DA',
            originalPrice: data['originalPrice'] ?? '0 DA',
          );
        },
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
              child: Stack(
                children: [
                  // Improved image loading
                  _loadImage(imagePath, width: double.infinity, height: 180),
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
                  // Sale tag if discounted
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey, size: 14),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        distance,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _specialOffers.length,
        itemBuilder: (context, index) {
          final offer = _specialOffers[index];
          return _buildSpecialOfferCard(
            offer['title']!,
            offer['discount']!,
            offer['description']!,
            offer['id']!,
            offer['image']!,
          );
        },
      ),
    );
  }

  Widget _buildSpecialOfferCard(
    String title,
    String discount,
    String description,
    String id,
    String imagePath,
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
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Improved image loading
            _loadImage(imagePath, width: 320, height: 180),
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
      ),
    );
  }

  // Helper method for image loading with fallback
  Widget _loadImage(String path, {double? width, double? height}) {
    // Check if it's a network image
    if (path.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey[500],
            size: 40,
          ),
        ),
      );
    }
    // Local asset image
    else {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey[500],
              size: 40,
            ),
          );
        },
      );
    }
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
              } else if (index == 3) {
                // Index 3 is for "Messages"
                Navigator.pushNamed(context, '/msg');
              } else if (index == 4) {
                // Index 4 is for "Profile"
                Navigator.pushNamed(context, '/profile');
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
