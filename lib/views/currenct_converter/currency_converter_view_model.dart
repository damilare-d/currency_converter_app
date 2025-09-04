
import 'package:currency_converter_app/models/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/exchange_service.dart';

class ExchangeState {
  final bool loading;
  final RatesModel? latestRates;
  final ConversionModel? conversion;
  final CodesModel? codes;
  final String? error;


  ExchangeState({
    this.loading = false,
    this.latestRates,
    this.conversion,
    this.codes,
    this.error,
  });

  ExchangeState copyWith({
    bool? loading,
    RatesModel? latestRates,
    ConversionModel? conversion,
    CodesModel? codes,
    String? error,
  }) {
    return ExchangeState(
      loading: loading ?? this.loading,
      latestRates: latestRates ?? this.latestRates,
      conversion: conversion ?? this.conversion,
      codes: codes ?? this.codes,
      error: error,
    );
  }
}

class ExchangeNotifier extends StateNotifier<ExchangeState> {
  final ExchangeService _service;

  ExchangeNotifier(this._service) : super(ExchangeState());

  Future<void> fetchLatestRates(String base) async {
    state = state.copyWith(loading: true);
    try {
      final result = await _service.getLatestRates(base);
      state = state.copyWith(latestRates: result, loading: false, error: null);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> fetchConversion(String from, String to) async {
    state = state.copyWith(loading: true);
    try {
      final result = await _service.getConversion(from, to);
      state = state.copyWith(conversion: result, loading: false, error: null);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> fetchCodes() async {
    state = state.copyWith(loading: true);
    try {
      final result = await _service.getSupportedCodes();
      state = state.copyWith(codes: result, loading: false, error: null);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final exchangeProvider = StateNotifierProvider<ExchangeNotifier, ExchangeState>(
      (ref) => ExchangeNotifier(ExchangeService()),
);
