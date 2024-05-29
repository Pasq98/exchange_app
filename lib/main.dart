import 'package:exchange_app/pages/home.dart';
import 'package:exchange_app/repository/HttpRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/fetch_rate/cubit.dart';
import 'resources/customColor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exchange app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.whiteBackground,
        title: const Center(
          child: Text(
            'Currency Converter',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: RepositoryProvider(
        create: (context) => HttpRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FetchRateCubit(httpRepository: context.read<HttpRepository>())..getCurrentUsdValue(),
            )
          ],
          child: Home(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
