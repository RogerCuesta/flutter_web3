import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/utils/constants.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi/weth_abi.json');
  String contractAddress = weth_contract;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'UNI'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String functionName, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(functionName);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}
