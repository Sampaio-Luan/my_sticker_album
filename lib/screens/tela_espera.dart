import 'package:flutter/material.dart';

class TelaEspera extends StatelessWidget {
  const TelaEspera({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}