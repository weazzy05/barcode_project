import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../cubit/scanner_cubit.dart';
import '../cubit/scanner_state.dart';
import '../widgets/product_card.dart';
import '../widgets/scan_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('home_screen'),
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ScanButton(
            key: const Key('home_scan_button'),
            onScanPressed: () {
              context.read<ScannerCubit>().scanBarcode('8901234567890');
            },
            onCameraPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => _CameraScannerScreen(
                    key: const Key('camera_scanner_screen'),
                    onBarcodeScanned: (barcode) {
                      context.read<ScannerCubit>().scanBarcode(barcode);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<ScannerCubit, ScannerState>(
              builder: (context, state) {
                return switch (state) {
                  ScannerInitial() => const Center(
                      child: Text('Scan a barcode to see product info'),
                    ),
                  ScannerLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ScannerSuccess(:final product) => SingleChildScrollView(
                      child: ProductCard(
                        key: Key('product_${product.barcode}'),
                        product: product,
                      ),
                    ),
                  ScannerError(:final message) => _ErrorContent(
                      key: const Key('error_content'),
                      message: message,
                      onRetry: () {
                        context.read<ScannerCubit>().reset();
                      },
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorContent({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraScannerScreen extends StatefulWidget {
  final void Function(String barcode) onBarcodeScanned;

  const _CameraScannerScreen({
    super.key,
    required this.onBarcodeScanned,
  });

  @override
  State<_CameraScannerScreen> createState() => _CameraScannerScreenState();
}

class _CameraScannerScreenState extends State<_CameraScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _scanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
        centerTitle: true,
      ),
      body: MobileScanner(
        controller: _controller,
        onDetect: (capture) {
          if (_scanned) return;
          final barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            _scanned = true;
            widget.onBarcodeScanned(barcodes.first.rawValue!);
          }
        },
      ),
    );
  }
}
