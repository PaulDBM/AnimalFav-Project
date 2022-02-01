import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class CodigoBarra extends StatelessWidget {
  final String codigo;
  const CodigoBarra({Key? key, required this.codigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cupón Generado')),
      body: Center(
          child: BarcodeWidget(
        barcode: Barcode.codabar(),
        data: codigo,
        width: 250,
        height: 150,
      )),
    );
  }
}
