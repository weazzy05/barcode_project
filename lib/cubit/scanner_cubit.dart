import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/result.dart';
import '../data/product_repository.dart';
import 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final ProductRepository _repository;

  ScannerCubit({required ProductRepository repository})
      : _repository = repository,
        super(const ScannerInitial());

  Future<void> scanBarcode(String barcode) async {
    emit(const ScannerLoading());

    final result = await _repository.getProduct(barcode);

    switch (result) {
      case Success(:final data):
        emit(ScannerSuccess(data));
      case Failure(:final error):
        emit(ScannerError(error));
    }
  }

  void reset() {
    emit(const ScannerInitial());
  }
}
