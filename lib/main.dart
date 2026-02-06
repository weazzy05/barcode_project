import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/scanner_cubit.dart';
import 'data/product_repository.dart';
import 'screens/home_screen.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => ScannerCubit(
          repository: ProductRepositoryImpl(
            apiService: ApiService(),
          ),
        ),
        child: const HomeScreen(),
      ),
    );
  }
}
