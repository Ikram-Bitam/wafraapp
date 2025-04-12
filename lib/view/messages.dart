import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  int _selectedIndex = 3; // Start with Messages tab selected
  final List<ChatPreview> _chats = [
    ChatPreview(
      name: "Sarah Ahmed",
      lastMessage: "Is the furniture still available?",
      time: "10:30 AM",
      imageUrl: "assets/images/person1.jpg",
      unreadCount: 2,
    ),
    ChatPreview(
      name: "Mohammed Ali",
      lastMessage: "Thanks for the vegetables! They were fresh.",
      time: "Yesterday",
      imageUrl: "assets/images/person2.jpg",
      unreadCount: 0,
    ),
    ChatPreview(
      name: "Fatima Zahra",
      lastMessage: "When can I pick up the electronics?",
      time: "Yesterday",
      imageUrl: "assets/images/person3.jpg",
      unreadCount: 1,
    ),
    ChatPreview(
      name: "Karim Benzema",
      lastMessage: "Do you still have those pastries?",
      time: "Monday",
      imageUrl: "assets/images/person4.jpg",
      unreadCount: 0,
    ),
    ChatPreview(
      name: "Amina Belkadi",
      lastMessage: "The fruit basket was amazing!",
      time: "Sunday",
      imageUrl: "assets/images/person5.jpg",
      unreadCount: 0,
    ),
    ChatPreview(
      name: "Hassan Makhlouf",
      lastMessage: "Are you interested in trading?",
      time: "Last Week",
      imageUrl: "assets/images/person6.jpg",
      unreadCount: 0,
    ),
    ChatPreview(
      name: "Layla Benchikh",
      lastMessage: "I'd like to donate some clothes.",
      time: "Last Week",
      imageUrl: "assets/images/person7.jpg",
      unreadCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildFilterTabs(),
            Expanded(
              child: _buildChatList(),
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
                  height: 30,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.orange,
                    size: 20,
                  ),
                );
              },
            ),
          ),
          // Title
          Text(
            "Messages",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search messages...",
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.orange,
                    width: 2.0,
                  ),
                ),
              ),
              child: Text(
                "All Messages",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Unread",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Important",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        final chat = _chats[index];
        return _buildChatItem(chat);
      },
    );
  }

  Widget _buildChatItem(ChatPreview chat) {
    return InkWell(
      onTap: () {
        _navigateToChatDetail(context, chat);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            // Profile Picture
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: AssetImage(chat.imageUrl),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) => {},
                    ),
                  ),
                  child: Center(
                    child: chat.imageUrl.isEmpty
                        ? Text(
                            chat.name.substring(0, 1),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          )
                        : null,
                  ),
                ),
                if (chat.unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        chat.unreadCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Message Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.name,
                        style: TextStyle(
                          fontWeight: chat.unreadCount > 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        chat.time,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: chat.unreadCount > 0
                          ? Colors.black87
                          : Colors.grey[600],
                      fontWeight: chat.unreadCount > 0
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToChatDetail(BuildContext context, ChatPreview chat) {
    // Show a snackbar to inform the user (temporary solution)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening chat with ${chat.name}'),
        duration: Duration(seconds: 1),
      ),
    );

    // Uncomment when you have a ChatDetailPage
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ChatDetailPage(chat: chat),
    //   ),
    // );
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
                _showCreateOptions(context);
              } else if (index == 0) {
                _navigateToExplorer(context);
              } else if (index == 4) {
                _navigateToProfile(context);
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

  void _navigateToExplorer(BuildContext context) {
    Navigator.pop(context); // Go back to ExplorerPage
  }

  void _navigateToProfile(BuildContext context) {
    // Show a snackbar to inform the user (temporary solution)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to Profile'),
        duration: Duration(seconds: 1),
      ),
    );

    // Uncomment when you have a ProfilePage
    // Navigator.pushNamed(context, '/profile');
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
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/offer');
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

// Model for chat preview data
class ChatPreview {
  final String name;
  final String lastMessage;
  final String time;
  final String imageUrl;
  final int unreadCount;

  ChatPreview({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.imageUrl,
    required this.unreadCount,
  });
}
