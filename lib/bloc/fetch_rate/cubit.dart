import 'package:bloc/bloc.dart';
import 'package:exchange_app/model/Currency.dart';
import 'package:exchange_app/model/CustomError.dart';

import '../../repository/HttpRepository.dart';
import 'state.dart';

class FetchRateCubit extends Cubit<FetchRateState> {
  final HttpRepository httpRepository;

  FetchRateCubit({required this.httpRepository}) : super(FetchRateState.initial());

  Future<void> getCurrentUsdValue() async {
    emit(state.copyWith(fetchRateEnum: FetchRateEnum.fetching));

    try {
      List<CurrencyModel> listOfCurrency = await httpRepository.getCurrentCurrency();

      emit(state.copyWith(fetchRateEnum: FetchRateEnum.retrieved, listOfCurrency: listOfCurrency));
    } catch (e) {
      emit(state.copyWith(
          fetchRateEnum: FetchRateEnum.error, error: CustomError(message: 'Failed retrieving', code: e.toString())));
    }
  }

  Future<void> updateRate(String valuta, num amount) async {
    emit(state.copyWith(fetchRateEnum: FetchRateEnum.fetching));

    num currentRateofSelectedValuta = state.listOfCurrency.where((element) => element.title == valuta).first.value;

    for (CurrencyModel currency in state.listOfCurrency) {
      currency.value = currency.value / currentRateofSelectedValuta * amount;
    }

    emit(state.copyWith(fetchRateEnum: FetchRateEnum.retrieved, listOfCurrency: state.listOfCurrency));
  }
}
