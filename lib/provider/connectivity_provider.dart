import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';


class ConnectivityProvider with ChangeNotifier {
  bool isConnected =true;

  checkConnection()async{
    isConnected = await checkInternetConnections();
    notifyListeners();
  }

  Future<bool> checkInternetConnections() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
