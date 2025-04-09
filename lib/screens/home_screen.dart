import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mixlify/providers/auth_provider.dart';
import 'package:mixlify/providers/chat_provider.dart';
import 'package:mixlify/screens/chat_screen.dart';
import 'package:mixlify/screens/search_screen.dart';
import 'package:mixlify/screens/settings_screen.dart';
import 'package:mixlify/widgets/conversation_list_item.dart';
import 'package:mixlify/widgets/platform_filter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<String> _platforms = [
    'All',
    'Matrix',
    'WhatsApp',
    'Messenger',
    'Telegram',
    'Instagram',
    'SMS',
  ];
  String _selectedPlatform = 'All';

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    await chatProvider.loadConversations();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPlatformSelected(String platform) {
    setState(() {
      _selectedPlatform = platform;
    });
    // Filter conversations by platform
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.filterByPlatform(platform);
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final conversations = chatProvider.filteredConversations;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mixlify',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show more options menu
              _showOptionsMenu(context);
            },
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? Column(
              children: [
                // Platform filter
                PlatformFilter(
                  platforms: _platforms,
                  selectedPlatform: _selectedPlatform,
                  onPlatformSelected: _onPlatformSelected,
                ),
                // Conversations list
                Expanded(
                  child: conversations.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          itemCount: conversations.length,
                          itemBuilder: (context, index) {
                            final conversation = conversations[index];
                            return ConversationListItem(
                              conversation: conversation,
                              isSelected: false,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                      conversation: conversation,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            )
          : const SettingsScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Start new conversation
        },
        child: const Icon(Icons.chat),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No conversations yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Start a new chat or connect more platforms',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text('Connect Platform'),
                onTap: () {
                  Navigator.pop(context);
                  // Show platform connection dialog
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Notification Settings'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to notification settings
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmLogout(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                authProvider.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
