import 'dart:async';

import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc_event.dart';
import 'package:flutter_web3/bloc/wallet_bloc/wallet_bloc_state.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_qrcode_modal_dart/walletconnect_qrcode_modal_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_web3/utils/constants.dart';

class WalletConnectUtils {
  http.Client httpClient = http.Client();
  Web3Client? ethClient;
  final contractAddress = uni_contract;
  var chainId;
  var address;

  late SessionStatus session;

  final sessionStorage = WalletConnectSecureStorage();

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

      chainId = session.chainId;

      print("Address: " + address!);
      print("Chain Id: " + chainId.toString());
    });

    connector.on('session_request', (payload) {
      print("session request: " + payload.toString());
    });

    connector.on('disconnect', (session) {
      print("disconnect: " + session.toString());
      //_walletBloc.add(WalletEventDisconnected(false));
    });

    // Create a new session
    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 137, //pass the chain id of a network. 137 is Polygon
        onDisplayUri: (uri) async {
          await launchUrl(Uri.parse(uri)); //call the launchUrl(uri) method
        },
      );
      sessionStorage.store(connector.session);
    } else {}
  }
}
