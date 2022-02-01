import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class CodigoQR extends StatelessWidget {
  final String codigo;
  const CodigoQR({Key? key, required this.codigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cupón Generado')),
      body: Center(
          child: BarcodeWidget(
        barcode: Barcode.qrCode(),
        data: codigo,
        width: 200,
        height: 200,
      ) /*BarCodeImage(
        params: UPCABarCodeParams(codigo),
      )*/
          ),
    );
  }
}
