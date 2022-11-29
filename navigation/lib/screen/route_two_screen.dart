import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'arguments: $arguments',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/three', arguments: 999);
          },
          child: const Text('Push Named'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => RouteThreeScreen(),
              ),
            );
          },
          child: const Text('Replace'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/three');
          },
          child: const Text('Push Replaced Named'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => RouteThreeScreen(),
              ),
              (route) => route.settings.name == '/',
            );
          },
          child: const Text('Push And Remove Until'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) => route.settings.name == '/',
            );
          },
          child: const Text('Push Named And Remove Until'),
        ),
      ],
    );
  }
}
