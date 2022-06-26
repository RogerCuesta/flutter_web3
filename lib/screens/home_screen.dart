import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc_state.dart';
import 'package:flutter_web3/utils/constants.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Client httpClient;
  Web3Client? web3Client;
  TextEditingController? userAddressText;

  @override
  void initState() {
    userAddressText = TextEditingController();
    httpClient = Client();
    web3Client = Web3Client(infuraKovanUrl, httpClient);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: HomeBloc(
          HomeStateLoading(),
        ),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Get your UNI balance:',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      controller: userAddressText,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        labelText: 'Enter your wallet',
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        userAddressText?.text = '';
                      });
                    },
                    child: Text(
                      'Check',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
