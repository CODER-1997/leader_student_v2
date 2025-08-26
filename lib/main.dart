
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:get/get_navigation/src/root/get_material_app.dart';
 import 'package:get_storage/get_storage.dart';
import 'package:leader_student_v2/screens/auth/login.dart';
 import 'package:leader_student_v2/screens/parents/parent_home_screen.dart';
 import 'package:upgrader/upgrader.dart';

 import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Upgrader.clearSavedSettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Leader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var box = GetStorage();
  //NetworkController networkController = Get.put(NetworkController());

  void setUpPushNotification() async {
    final fcm = await FirebaseMessaging.instance;

    await fcm.requestPermission(
    );


    await FirebaseMessaging.instance.subscribeToTopic("students");

  }

  @override
  void initState() {
setUpPushNotification();
super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   box.read('isLogged') == null
          ? Login()
          : ParentsAdminHomeScreen()


    );

    //
    //
    // return Scaffold(
    //   body: Obx(() => networkController.connectionType != 0
    //       ? ( Container(
    //               child: box.read('isLogged') == null
    //                   ? Login()
    //                   : ParentsAdminHomeScreen()
    //       ,
    //             )
    //          )
    //       : LostConnection()),
    // );
  }
}
