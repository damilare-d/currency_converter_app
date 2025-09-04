import 'package:currency_converter_app/views/currenct_converter/currency_converter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Exchange',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Clean Material 3 look
        colorSchemeSeed: Colors.blue,
      ),
      home: const CurrencyConverterView(),
    );
  }
}
