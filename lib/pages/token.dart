import 'package:flutter/material.dart';

class Token extends StatelessWidget {
  final String codigo;
  const Token({Key? key, required this.codigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Cupón Generado')),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
              child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Token:',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                codigo,
                style: const TextStyle(fontSize: 24.0),
              )
            ],
          )),
        ));
  }
}
