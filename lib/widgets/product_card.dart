import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import 'size_availability.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const Key('product_card'),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _ProductImage(key: const Key('product_image'), imageUrl: product.imageUrl),
            const SizedBox(height: 16),
            _ProductInfo(key: const Key('product_info'), product: product),
            const SizedBox(height: 16),
            SizeAvailability(key: const Key('product_sizes'), sizes: product.sizes),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;

  const _ProductImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => const SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => const SizedBox(
          height: 200,
          child: Center(child: Icon(Icons.image_not_supported, size: 48)),
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final Product product;

  const _ProductInfo({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name, style: textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(product.brand, style: textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        )),
        const SizedBox(height: 4),
        Text(product.category, style: textTheme.bodyMedium),
        const SizedBox(height: 8),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Barcode: ${product.barcode}',
          style: textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
