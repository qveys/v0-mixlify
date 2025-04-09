import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mixlify/models/message.dart';
import 'package:mixlify/providers/chat_provider.dart';
import 'package:mixlify/screens/chat_screen.dart';
import 'package:mixlify/utils/time_formatter.dart';
import 'package:mixlify/widgets/platform_indicator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedPlatform = 'All';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _showFilters = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      _searchQuery = _searchController.text;
    });
    
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.searchMessages(
      query: _searchQuery,
      platform: _selectedPlatform == 'All' ? null : _selectedPlatform,
      startDate: _startDate,
      endDate: _endDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final searchResults = chatProvider.searchResults;
    final platforms = ['All', 'Matrix', 'WhatsApp', 'Messenger', 'Telegram', 'Instagram', 'SMS'];

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search messages...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
            ),
          ),
          onSubmitted: (_) => _performSearch(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showFilters ? Icons.filter_list_off : Icons.filter_list,
              color: _showFilters ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showFilters ? 120 : 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter by:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    // Platform filter
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: platforms.length,
                        itemBuilder: (context, index) {
                          final platform = platforms[index];
                          final isSelected = platform == _selectedPlatform;
                          
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(platform),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() {
                                  _selectedPlatform = platform;
                                });
                                _performSearch();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Date filter
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.calendar_today, size: 16),
                            label: Text(_startDate != null
                                ? TimeFormatter.formatDate(_startDate!)
                                : 'Start Date'),
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _startDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                setState(() {
                                  _startDate = date;
                                });
                                _performSearch();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.calendar_today, size: 16),
                            label: Text(_endDate != null
                                ? TimeFormatter.formatDate(_endDate!)
                                : 'End Date'),
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _endDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                setState(() {
                                  _endDate = date;
                                });
                                _performSearch();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Search results
          Expanded(
            child: _searchQuery.isEmpty
                ? _buildSearchPrompt()
                : searchResults.isEmpty
                    ? _buildNoResults()
                    : ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final result = searchResults[index];
                          return _buildSearchResultItem(result);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Search for messages',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Use keywords, names, or dates',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(Message result) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final conversation = chatProvider.getConversationById(result.conversationId);
    
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: result.senderAvatar != null
            ? NetworkImage(result.senderAvatar!)
            : null,
        child: result.senderAvatar == null
            ? Text(
                result.senderName.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontSize: 12),
              )
            : null,
      ),
      title: Row(
        children: [
          Text(
            result.senderName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          PlatformIndicator(platform: result.platform),
          const Spacer(),
          Text(
            TimeFormatter.formatMessageTime(result.timestamp),
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
      subtitle: Text(
        result.content,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        if (conversation != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(
                conversation: conversation,
              ),
            ),
          );
        }
      },
    );
  }
}
