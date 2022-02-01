import 'package:animal_fav/models/cupon_generado.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class CodigoBarraPage extends StatelessWidget {
  const CodigoBarraPage({Key? key, required this.cupon}) : super(key: key);

  final CuponGenerado cupon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Cupón Generado')),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BarcodeWidget(
                  barcode: Barcode.codabar(),
                  data: cupon.codigo,
                  width: 250,
                  height: 125,
                ),
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
              ]),
        ));
  }
}
