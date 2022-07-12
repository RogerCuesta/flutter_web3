import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_web3/bloc/home_bloc/home_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_web3/utils/constants.dart';

class EthereumUtils {
  http.Client httpClient = http.Client();
  Web3Client? ethClient;
  final contractAddress = uni_contract;

  void initialSetup() async {
    String infura = infuraKovanUrl;
    ethClient = Web3Client(infura, httpClient);
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
