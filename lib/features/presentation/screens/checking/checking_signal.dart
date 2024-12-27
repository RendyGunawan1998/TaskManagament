import 'package:taskmanagement/core.dart';

class CheckingPageScreen extends StatefulWidget {
  const CheckingPageScreen({super.key});

  @override
  State<CheckingPageScreen> createState() => _CheckingPageScreenState();
}

class _CheckingPageScreenState extends State<CheckingPageScreen> {
  @override
  void initState() {
    super.initState();
    checkConnectionAndNavigate();
  }

  static Future<bool> isConnectedToInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    print('connectivityResult :: $connectivityResult');
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      print('return true');
      return true;
    } else {
      return false;
    }
  }

  Future<void> checkConnectionAndNavigate() async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected) {
      print('not connected');
      Get.offAll(() => ListTaskScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            hbox(10),
            Text('Checking signal...')
          ],
        ),
      )),
    );
  }
}
