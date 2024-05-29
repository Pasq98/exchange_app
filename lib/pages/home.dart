import 'package:flutter/material.dart';
import '../resources/customColor.dart';
import '../widget/currencyList.dart';
import '../widget/inputForm.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.whiteBackground,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: InputForm(),
              ),
              Flexible(child: CurrencyList()),
            ],
          ),
        ));
  }
}
