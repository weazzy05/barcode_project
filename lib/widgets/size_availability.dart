import 'package:flutter/material.dart';

import '../models/product.dart';

class SizeAvailability extends StatelessWidget {
  final List<SizeInfo> sizes;

  const SizeAvailability({
    super.key,
    required this.sizes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('size_availability_column'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size Availability',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sizes.map((size) => _SizeChip(key: Key('size_chip_${size.size}'), sizeInfo: size)).toList(),
        ),
      ],
    );
  }
}

class _SizeChip extends StatelessWidget {
  final SizeInfo sizeInfo;

  const _SizeChip({
    super.key,
    required this.sizeInfo,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Chip(
      label: Text(
        '${sizeInfo.size} (${sizeInfo.quantity})',
        style: TextStyle(
          color: sizeInfo.available ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
        ),
      ),
      backgroundColor: sizeInfo.available
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerHighest,
      side: BorderSide(
        color: sizeInfo.available ? colorScheme.primary : colorScheme.outline,
      ),
    );
  }
}
