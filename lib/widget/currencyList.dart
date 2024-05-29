import 'package:exchange_app/bloc/fetch_rate/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/fetch_rate/state.dart';

class CurrencyList extends StatefulWidget {
  const CurrencyList({Key? key}) : super(key: key);

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchRateCubit, FetchRateState>(listener: (context, state) {
      if (state.fetchRateEnum == FetchRateEnum.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error.message)));
      }
    }, builder: (context, state) {
      if (state.fetchRateEnum == FetchRateEnum.retrieved) {
        return ListView.builder(
          itemCount: state.listOfCurrency.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.lightGreen.shade100,
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.lightGreen.shade300,
                  radius: 24,
                  child: Text(
                      style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.9)), state.listOfCurrency[index].title),
                ),
                title: Text(
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  state.listOfCurrency[index].value.toStringAsFixed(4),
                ),
              ),
            );
          },
        );
      }

      if (state.fetchRateEnum == FetchRateEnum.fetching) {
        return const CircularProgressIndicator();
      }

      if (state.fetchRateEnum == FetchRateEnum.error) {
        return const Center(child: Text('Try to restart'));
      }

      return Text(state.fetchRateEnum.name);
    });
  }
}
