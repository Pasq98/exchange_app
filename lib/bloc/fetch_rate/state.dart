import 'package:equatable/equatable.dart';
import 'package:exchange_app/model/Currency.dart';

import '../../model/CustomError.dart';

enum FetchRateEnum { initial, fetching, retrieved, error }

class FetchRateState extends Equatable {
  final FetchRateEnum fetchRateEnum;
  final List<CurrencyModel> listOfCurrency;
  final CustomError error;

  FetchRateState({required this.fetchRateEnum, required this.listOfCurrency, required this.error});

  factory FetchRateState.initial() {
    return FetchRateState(
      fetchRateEnum: FetchRateEnum.initial,
      listOfCurrency: const [],
      error: const CustomError(),
    );
  }

  @override
  List<Object?> get props => [fetchRateEnum, listOfCurrency];

  FetchRateState copyWith({
    FetchRateEnum? fetchRateEnum,
    List<CurrencyModel>? listOfCurrency,
    CustomError? error,
  }) {
    return FetchRateState(
        fetchRateEnum: fetchRateEnum ?? this.fetchRateEnum,
        error: error ?? this.error,
        listOfCurrency: listOfCurrency ?? this.listOfCurrency);
  }
}
