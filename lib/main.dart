import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:senfood/screens/introScreen.dart';
import 'package:senfood/screens/navigateAuthScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:senfood/screens/auth.dart';
import 'package:introduction_screen/introduction_screen.dart';

Map<String, Map<String, String>> translations = {
  'ar': {
    'New_Order_Title': 'طلب جديد',
    'New_Order_Body': 'لديك طلب جديد برقم{args}',
  },
  'en': {
    'New_Order_Title': 'New order',
    'New_Order_Body': 'You has new order with number {args}',
  }
};
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage _notification) async {
  var strings = translations[(await getSavedLocale()).languageCode] ??
      translations['en'] ??
      {};

  var title = strings[_notification.data['title_key']];
  var body = strings[_notification.data['body_key']]
      ?.replaceAll('{args}', _notification.data['body_args']);
  FCMConfig.instance.displayNotification(title: title ?? '', body: body ?? '');
}
Future<Locale> getSavedLocale() async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.reload();
  var locale = prefs.containsKey('locale') ? prefs.getString('locale') : null;
  return Locale(locale ?? 'ar');
}

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FCMConfig.instance
      .init(onBackgroundMessage: _firebaseMessagingBackgroundHandler)
      .then((value) {
    if (!kIsWeb) {
      FCMConfig.messaging.subscribeToTopic('Aicha');
    }
  });
  runApp(MyApp());
}






class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var darkTheme = ThemeData.dark().copyWith(primaryColor: Colors.blue);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone number',
      themeMode: ThemeMode.light,
      darkTheme: darkTheme,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: NavigateAuthScreen (),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'SN';
  PhoneNumber number = PhoneNumber(isoCode: 'SN');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: controller,
              formatInput: false,
              keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
            SizedBox(

              height:
              20,
            ),
            ElevatedButton(
                child: Text('Validate'),
                onPressed: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('numero', controller.text);
                 // print(controller.text);
                  Navigator.push(
                 context,
                   MaterialPageRoute(builder: (context) => AuthPage()),
                 );
                }

            ),


          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}