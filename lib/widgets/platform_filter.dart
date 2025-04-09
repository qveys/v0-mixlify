import 'package:flutter/material.dart';
import 'package:mixlify/widgets/platform_indicator.dart';

class PlatformFilter extends StatelessWidget {
  final List<String> platforms;
  final String selectedPlatform;
  final Function(String) onPlatformSelected;

  const PlatformFilter({
    super.key,
    required this.platforms,
    required this.selectedPlatform,
    required this.onPlatformSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: platforms.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final platform = platforms[index];
          final isSelected = platform == selectedPlatform;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PlatformIndicator(platform: platform),
                  const SizedBox(width: 8),
                  Text(platform),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => onPlatformSelected(platform),
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              checkmarkColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline.withOpacity(0.5),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
