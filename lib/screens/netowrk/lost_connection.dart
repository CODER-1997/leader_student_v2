// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controllers/network_controller/network_controller.dart';
//
// class LostConnection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final NetworkController controller = Get.put(NetworkController());
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 32),
//               child: Image.asset('assets/not_internet.png'),
//             ),
//             FittedBox(
//               child: Text(
//                 'Oops! something went wrong.',
//                 style: TextStyle(fontSize: 24, color: Colors.black
//                     ,fontWeight: FontWeight.w900),
//               ),
//             ),
//             SizedBox(height: 32,),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Check your connection !. May be your Wi-Fi or internet switch off',
//                 style: TextStyle(fontSize: 16, color: CupertinoColors.secondaryLabel,fontWeight: FontWeight.w400),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
