import 'package:animal_fav/models/cupon_generado.dart';
import 'package:flutter/material.dart';

class TokenPage extends StatelessWidget {
  const TokenPage({Key? key, required this.cupon}) : super(key: key);

  final CuponGenerado cupon;

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
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    cupon.codigo,
                    style: const TextStyle(fontSize: 24.0),
                  )),
              ElevatedButton(
                onPressed: () {
                  cupon.canjearCupon().then((res) => {
                        if (res.statusCode == 200)
                          {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              'Cupón canjeado',
                              style: TextStyle(fontSize: 18.0),
                            ))),
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst)
                          }
                        else
                          {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              'Error al canjear el cupón',
                              style: TextStyle(fontSize: 18.0),
                            )))
                          }
                      });
                },
                child: const Text('Marcar cupón como canjeado',
                    style: TextStyle(fontSize: 18.0)),
              ),
            ],
          )),
        ));
  }
}
