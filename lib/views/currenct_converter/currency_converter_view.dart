import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'currency_converter_view_model.dart';

class CurrencyConverterView extends ConsumerWidget {
  const CurrencyConverterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exchangeProvider);
    final notifier = ref.read(exchangeProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Exchange Rates")),
      body: Center(
        child: state.loading
            ? const CircularProgressIndicator()
            : state.error != null
            ? Text("Error: ${state.error}")
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => notifier.fetchLatestRates("GBP"),
              child: const Text("Get Latest GBP Rates"),
            ),
            ElevatedButton(
              onPressed: () => notifier.fetchConversion("USD", "EUR"),
              child: const Text("Convert USD to EUR"),
            ),
            ElevatedButton(
              onPressed: () => notifier.fetchCodes(),
              child: const Text("Get Supported Codes"),
            ),
            if (state.latestRates != null)
              Text("Base: ${state.latestRates!.baseCode}"),
            if (state.conversion != null)
              Text("1 USD = ${state.conversion!.rate} EUR"),
            if (state.codes != null)
              Text("Codes: ${state.codes!.supportedCodes.length}"),
          ],
        ),
      ),
    );
  }
}
