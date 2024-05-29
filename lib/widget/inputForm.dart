import 'package:exchange_app/bloc/fetch_rate/cubit.dart';
import 'package:exchange_app/bloc/fetch_rate/state.dart';
import 'package:exchange_app/model/Currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputForm extends StatefulWidget {
  const InputForm({Key? key}) : super(key: key);

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  String _selectedValue = 'USD';
  num _selectedAmount = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchRateCubit, FetchRateState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.fetchRateEnum == FetchRateEnum.fetching) {
          return TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
              labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
              floatingLabelStyle: const TextStyle(color: Colors.green),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.lightGreen, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(252, 171, 100, 1),
                ),
              ),
            ),
            keyboardType: TextInputType.number,
          );
        }

        if (state.fetchRateEnum == FetchRateEnum.retrieved) {
          List<CurrencyModel> listOfCurrency = context.read<FetchRateCubit>().state.listOfCurrency;

          return Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: _selectedAmount.toString(),
                  labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                  floatingLabelStyle: const TextStyle(color: Colors.green),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.lightGreen, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(252, 171, 100, 1),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (amount) {
                  if (amount.length > 0 && amount.isNotEmpty && num.tryParse(amount)! > 0) {
                    setState(() {
                      _selectedAmount = num.parse(amount);
                    });
                  }
                },
                onSubmitted: (amount) {
                  if (amount.length > 0 && amount.isNotEmpty && num.tryParse(amount)! > 0) {
                    context.read<FetchRateCubit>().updateRate(_selectedValue, num.parse(amount));
                  }
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: DropdownButton(
                  isExpanded: true,
                  value: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value!;
                      context.read<FetchRateCubit>().updateRate(_selectedValue, _selectedAmount);
                    });
                  },
                  items: listOfCurrency.map((CurrencyModel currency) {
                    return DropdownMenuItem(
                      value: currency.title,
                      child: Text(currency.title),
                    );
                  }).toList(),
                ),
              )
            ],
          );
        }

        if (state.fetchRateEnum == FetchRateEnum.error) {
          return TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
              labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
              floatingLabelStyle: const TextStyle(color: Colors.green),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.lightGreen, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(252, 171, 100, 1),
                ),
              ),
            ),
            keyboardType: TextInputType.number,
          );
        }
        return const Text('This shound not happen...');
      },
    );
  }
}
