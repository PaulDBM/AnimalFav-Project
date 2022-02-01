import 'dart:convert';
import 'dart:math';
import 'package:animal_fav/models/cupon_generado.dart';
import 'package:animal_fav/models/tipo_cupon.dart';
import 'package:animal_fav/pages/codigo_barra.dart';
import 'package:animal_fav/pages/codigo_qr.dart';
import 'package:animal_fav/pages/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.sample.dart';

class TiposCuponPage extends StatefulWidget {
  const TiposCuponPage({Key? key, required this.title, required this.idCupon})
      : super(key: key);
  final String title;
  final int idCupon;

  @override
  State<TiposCuponPage> createState() => _TiposCuponPageState();
}

class _TiposCuponPageState extends State<TiposCuponPage> {
  late Future<List<TipoCupon>> tiposCupon;
  final cuponesListKey = GlobalKey<_TiposCuponPageState>();

  @override
  void initState() {
    super.initState();
    tiposCupon = getTiposCupon();
  }

  Future<List<TipoCupon>> getTiposCupon() async {
    final response =
        await http.get(Uri.parse("${Env.urlprefix}/api/tipos_cupon"));
    List<TipoCupon> tiposCupon;
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      tiposCupon = items.map<TipoCupon>((json) {
        return TipoCupon.fromJson(json);
      }).toList();
    } else {
      tiposCupon = [];
    }
    return tiposCupon;
  }

  Future<void> _refresh() async {
    Future<List<TipoCupon>> _tiposCupon = getTiposCupon();
    setState(() {
      tiposCupon = _tiposCupon;
    });
  }

  Future<http.Response> guardarCuponGenerado(CuponGenerado cuponGenerado) {
    final response = http.post(
      Uri.parse("${Env.urlprefix}/api/cupon_generado"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'codigo': cuponGenerado.codigo,
        'cupon': cuponGenerado.cupon.toString(),
        'expiracion': cuponGenerado.expiracion.toString(),
        'tipo_cupon': cuponGenerado.tipocupon.toString(),
      }),
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<List<TipoCupon>>(
              future: tiposCupon,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return RefreshIndicator(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        TipoCupon data = snapshot.data[index];
                        return Card(
                            child: TextButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(65.0)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.hovered)) {
                                        return Colors.blue.withOpacity(0.04);
                                      }
                                      if (states.contains(
                                              MaterialState.focused) ||
                                          states.contains(
                                              MaterialState.pressed)) {
                                        return Colors.blue.withOpacity(0.12);
                                      }
                                      return null; // Defer to the widget's default.
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  const _digits = '0123456789';
                                  Random _rnd = Random();
                                  String code = String.fromCharCodes(
                                      Iterable.generate(
                                          12,
                                          (_) => _digits.codeUnitAt(
                                              _rnd.nextInt(_digits.length))));
                                  DateTime expiracion = DateTime.now()
                                      .add(const Duration(hours: 6));
                                  CuponGenerado generado = CuponGenerado(
                                      codigo: code,
                                      cupon: widget.idCupon,
                                      expiracion: expiracion,
                                      tipocupon: data.id);
                                  var response = guardarCuponGenerado(generado);
                                  response.then((res) => {
                                        if (res.statusCode == 201)
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                              'Cupón generado exitosamente',
                                              style: TextStyle(fontSize: 18.0),
                                            ))),
                                            if (data.nombre.contains('Barra'))
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CodigoBarraPage(
                                                              cupon: generado)),
                                                )
                                              }
                                            else if (data.nombre
                                                .contains('Token'))
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TokenPage(
                                                              cupon: generado)),
                                                )
                                              }
                                            else if (data.nombre.contains('QR'))
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CodigoQRPage(
                                                              cupon: generado)),
                                                )
                                              }
                                          }
                                        else
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                              'Error al generar cupón',
                                              style: TextStyle(fontSize: 18.0),
                                            )))
                                          }
                                      });
                                },
                                child: Text(
                                  data.nombre,
                                  style: const TextStyle(fontSize: 28.0),
                                )));
                      },
                    ),
                    onRefresh: _refresh);
              },
            )
          ],
        ),
      ),
    )

        // This trailing comma makes auto-formatting nicer for build methods.
        ;
  }
}
