import 'package:currency_converter_app/views/currenct_converter/widget/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/flag_utils.dart';

import 'currency_converter_view_model.dart';

class CurrencyConverterView extends ConsumerStatefulWidget {
  const CurrencyConverterView({super.key});

  @override
  ConsumerState<CurrencyConverterView> createState() => _CurrencyConverterViewState();
}

class _CurrencyConverterViewState extends ConsumerState<CurrencyConverterView> {
  String fromCode = "USD";
  String toCode = "NGN";
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(exchangeProvider.notifier).fetchCodes();
    });
  }

  void _convert() {
    ref.read(exchangeProvider.notifier)
        .fetchConversion( fromCode,toCode,);
  }

  void _showCurrencyPicker({required bool isFrom}) {
    final codes = ref.read(exchangeProvider).codes?.supportedCodes ?? [];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: codes.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final code = codes[index][0]; // "USD"
            final name = codes[index][1]; // "United States Dollar"

            return ListTile(
              leading: Text(currencyCodeToEmoji(code), style: const TextStyle(fontSize: 24)),
              title: Text(
                code,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF26278D),
                ),
              ),
              subtitle: Text(name),
              onTap: () {
                setState(() {
                  if (isFrom) {
                    fromCode = code;
                  } else {
                    toCode = code;
                  }
                });
                Navigator.pop(context);
                _convert();
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exchangeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20,),
              const Text(
                "Currency Converter",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0xFF1F2261),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Check live rates, set rate alerts, receive notifications and more.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF808080),
                ),
              ),
              const SizedBox(height: 40),

              // Conversion Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Title for row amount
                    const Text(
                      "Amount",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff989898),
                      ),
                    ),

                    SizedBox(height: 14,),

                    // From Row
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CurrencySelector(
                            flag: currencyCodeToEmoji(fromCode),
                            code: fromCode,
                            onTap: () => _showCurrencyPicker(isFrom: true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFEFEF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                              controller: _amountController,
                              onChanged: (_) => _convert(),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 20, fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "0.00",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Swap Icon Row
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              final temp = fromCode;
                              fromCode = toCode;
                              toCode = temp;
                            });
                            _convert();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            height: 44,
                            width: 44,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF1F2261),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.swap_vert, color: Colors.white),
                          ),
                        ),
                        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                      ],
                    ),
                    const SizedBox(height: 20),


                    // Title for converted row amount
                    const Text(
                      "Converted Amount",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff989898),
                      ),
                    ),

                    SizedBox(height: 14,),

                    // To Row
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CurrencySelector(
                            flag: currencyCodeToEmoji(toCode),
                            code: toCode,
                            onTap: () => _showCurrencyPicker(isFrom: false),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFEFEF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                state.conversion?.rate.toStringAsFixed(2) ?? "0.00",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Indicative Exchange Rate
              if (state.conversion?.rate != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Indicative Exchange Rate",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: Color(0xff9B9B9B)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "1 $fromCode = ${(state.conversion!.rate / (double.tryParse(_amountController.text) ?? 1)).toStringAsFixed(2)} $toCode",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
