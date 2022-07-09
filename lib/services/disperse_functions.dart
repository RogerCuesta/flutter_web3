import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_web3/utils/constants.dart';

class EthereumUtils {
  http.Client httpClient = http.Client();
  Web3Client? ethClient;
  final contractAddress = uni_contract;
  var chainId;
  var address;
  // Create a connector
  final connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    /*uri:
        'wc:8a5e5bdc-a0e4-4702-ba63-8f1a5655744f@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=41791102999c339c844880b23950704cc43aa840f3739e365323cda4dfa89e7a',*/
    clientMeta: PeerMeta(
      name: 'WalletConnect',
      description: 'WalletConnect Developer App',
      url: 'https://walletconnect.org',
      icons: [
        'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ],
    ),
  );

// Create a new session

  void initialSetup() async {
    String infura = infuraKovanUrl;
    ethClient = Web3Client(infura, httpClient);
  }

  Future<void> connectWallet() async {
    final connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'Disperse App Connect',
          description: 'WalletConnect Developer App',
          url: 'https://walletconnect.org',
          icons: [
            'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]),
    );
    // Subscribe to events
    connector.on('connect', (SessionStatus session) {
      print("connect: " + session.toString());

      address = session.accounts[0];

      
      //chainId = session?.chainId;

      print("Address: " + address!);
      //print("Chain Id: " + chainId.toString());
    });

    connector.on('session_request', (payload) {
      print("session request: " + payload.toString());
    });

    connector.on('disconnect', (session) {
      print("disconnect: " + session.toString());
    });

    // Create a new session
    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 137, //pass the chain id of a network. 137 is Polygon
        onDisplayUri: (uri) async {
          await launchUrl(Uri.parse(uri)); //call the launchUrl(uri) method
        },
      );
    }
  }

  void walletConnectSetup() async {
    // Subscribe to events
    connector.on('connect', (session) {
      session = session;
    });
    connector.on('session_update', (payload) => print(payload));
    connector.on('disconnect', (session) => print(session));

    final session = await connector.createSession(
      chainId: 4160,
      onDisplayUri: (uri) => print(uri),
    );
    connector.connect(
      chainId: 4160,
      onDisplayUri: (uri) => print(uri),
    );
    print("I'ts connected ? --> " + connector.connected.toString());
  }

  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString("assets/abi/weth_abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "UniSwap"),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future<BigInt> getBalance(String address) async {
    EthereumAddress ethereumAddress = EthereumAddress.fromHex(address);
    List<dynamic>? result = await query("balanceOf", [ethereumAddress]);
    BigInt myData = result != null ? result[0] : null;
    final timer =
        Timer(const Duration(seconds: 5), () => print('Timer finished'));
    return myData;
  }

  // Make query to contracts
  Future<List<dynamic>?> query(String functionName, List<dynamic> args) async {
    final contract = await getDeployedContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient?.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  //Submit transaction (send, sign, etc)
  Future<String?> submit(String functionName, List<dynamic> args) async {
    try {
      EthPrivateKey credential = EthPrivateKey.fromHex(owner_private_key);
      DeployedContract contract = await getDeployedContract();
      final ethFunction = contract.function(functionName);
      final result = await ethClient?.sendTransaction(
          credential,
          Transaction.callContract(
              contract: contract,
              function: ethFunction,
              parameters: args,
              maxGas: 100000),
          chainId: 4);
      return result;
    } catch (e) {
      print("Something wrong happened!");
    }
    return null;
  }
}
