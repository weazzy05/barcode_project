import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  final VoidCallback onScanPressed;
  final VoidCallback onCameraPressed;

  const ScanButton({
    super.key,
    required this.onScanPressed,
    required this.onCameraPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('scan_button_padding'),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              key: const Key('mock_scan_button'),
              onPressed: onScanPressed,
              icon: const Icon(Icons.qr_code),
              label: const Text('Mock Scan'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              key: const Key('camera_scan_button'),
              onPressed: onCameraPressed,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera Scan'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
