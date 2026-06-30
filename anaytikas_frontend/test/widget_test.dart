// // // This is a basic Flutter widget test.
// // //
// // // To perform an interaction with a widget in your test, use the WidgetTester
// // // utility in the flutter_test package. For example, you can send tap and scroll
// // // gestures. You can also use WidgetTester to find child widgets in the widget
// // // tree, read text, and verify that the values of widget properties are correct.

// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';

// // import 'package:anaytikas_frontend/main.dart';

// // void main() {
// //   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
// //     // Build our app and trigger a frame.
// //     await tester.pumpWidget(const MyApp());

// //     // Verify that our counter starts at 0.
// //     expect(find.text('0'), findsOneWidget);
// //     expect(find.text('1'), findsNothing);

// //     // Tap the '+' icon and trigger a frame.
// //     await tester.tap(find.byIcon(Icons.add));
// //     await tester.pump();

// //     // Verify that our counter has incremented.
// //     expect(find.text('0'), findsNothing);
// //     expect(find.text('1'), findsOneWidget);
// //   });
// // }

// // import 'package:flutter/material.dart';

// // Test API
// import 'package:anaytikas_frontend/core/config/api/api_helper.dart';
// import 'package:anaytikas_frontend/core/config/network/connectivity_helper.dart';
// import 'package:anaytikas_frontend/core/shared/data/datasources/account_remote_data_source.dart';
// import 'package:anaytikas_frontend/core/shared/data/repositories/account_repository_impl.dart';
// import 'package:http/http.dart' as http;

// void main() async {
//   final client = http.Client();
//   final apiHelper = ApiHelper(
//     client: client,
//     baseUrl: 'https://analitikas-system.vercel.app/api/',
//   );

//   final connectivityHelper = ConnectivityHelper();
//   final accountRemoteDataSource = AccountRemoteDataSourceImpl(
//     apiHelper: apiHelper,
//   );
//   final accountRepo = AccountRepositoryImpl(
//     remoteDataSource: accountRemoteDataSource,
//     connectivityHelper: connectivityHelper,
//   );

//   try {
//     final message = await accountRepo.register('widiartamade384@gmail.com');
//     print('test: $message');
//   } catch (e) {
//     print('gagal');
//   }
// }
