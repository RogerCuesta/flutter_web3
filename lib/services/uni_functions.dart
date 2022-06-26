import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:flutter_web3/utils/constants.dart';

class EthereumUtils {
  http.Client httpClient = http.Client();
  Web3Client? ethClient;
  final contractAddress = uni_contract;

  void initialSetup() {
    String infura = infuraKovanUrl;
    ethClient = Web3Client(infura, httpClient);
  }

  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString("assets/abi/weth_abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "UniSwap"),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future getBalance() async {
    List<dynamic>? result = await query("getBalance", []);
    var myData = result != null ? result[0] : null;
    return myData;
  }

  Future<List<dynamic>?> query(String functionName, List<dynamic> args) async {
    final contract = await getDeployedContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient?.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

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
