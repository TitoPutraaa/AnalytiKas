import 'package:anaytikas_frontend/core/shared/domain/presentation/manager/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homeanalisis extends StatelessWidget {
  const Homeanalisis({super.key});

  @override
  Widget build(BuildContext context) {
    // return Text("Home Analisis", style: TextStyle(fontSize: 40));

    return ElevatedButton(
      onPressed: () async {
        try {
          final message = await context.read<RegisterProvider>().register(
            'widiartamade384@gmail.com',
          );
          print(message);
        } catch (e) {
          print('error ');
        }
      },
      child: Text('Test Register'),
    );
  }
}
