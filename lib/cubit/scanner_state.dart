import '../models/product.dart';

sealed class ScannerState {
  const ScannerState();
}

final class ScannerInitial extends ScannerState {
  const ScannerInitial();
}

final class ScannerLoading extends ScannerState {
  const ScannerLoading();
}

final class ScannerSuccess extends ScannerState {
  final Product product;
  const ScannerSuccess(this.product);
}

final class ScannerError extends ScannerState {
  final String message;
  const ScannerError(this.message);
}
