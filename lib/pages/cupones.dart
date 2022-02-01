import 'dart:convert';

import 'package:animal_fav/models/cupon.dart';
import 'package:animal_fav/models/tipo_tienda.dart';
import 'package:animal_fav/pages/tipo_cupones.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.sample.dart';

class CuponesPage extends StatefulWidget {
  const CuponesPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CuponesPage> createState() => _CuponesPageState();
}

class _CuponesPageState extends State<CuponesPage> {
  late Future<List<Cupon>> cupones;
  late Future<List<TipoTienda>> tiposTienda;
  final cuponesListKey = GlobalKey<_CuponesPageState>();

  @override
  void initState() {
    super.initState();
    tiposTienda = getTiposTiendas();
    cupones = getCupones();
  }

  Future<List<TipoTienda>> getTiposTiendas() async {
    final response =
        await http.get(Uri.parse("${Env.urlprefix}/api/tipos_tienda"));
    List<TipoTienda> tiposTienda;
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      tiposTienda = items.map<TipoTienda>((json) {
        return TipoTienda.fromJson(json);
      }).toList();
    } else {
      tiposTienda = [];
    }
    return tiposTienda;
  }

  Future<List<Cupon>> getCupones() async {
    final response = await http.get(Uri.parse("${Env.urlprefix}/api/cupones"));
    List<Cupon> cupones;
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      cupones = items.map<Cupon>((json) {
        return Cupon.fromJson(json);
      }).toList();
      tiposTienda.then((tiposTienda) => {
            cupones
                .map((cupon) => {
                      cupon.nombreTipoTienda = tiposTienda
                          .where(
                              (tipoTienda) => tipoTienda.id == cupon.tipotienda)
                          .first
                          .nombre
                    })
                .toList()
          });
    } else {
      cupones = [];
    }
    return cupones;
  }

  Future<void> _refresh() async {
    Future<List<Cupon>> _cupones = getCupones();
    Future<List<TipoTienda>> _tiposTienda = getTiposTiendas();
    setState(() {
      tiposTienda = _tiposTienda;
      cupones = _cupones;
    });
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
            FutureBuilder<List<Cupon>>(
              future: cupones,
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
                        Cupon data = snapshot.data[index];
                        List<String> nombre = data.nombre.split("-");
                        return Card(
                          child: ListTile(
                            key: Key(data.id.toString()),
                            title: Text(
                              nombre[0],
                              style: const TextStyle(fontSize: 24.0),
                            ),
                            subtitle: Text(
                              nombre[1] + " - Tienda " + data.nombreTipoTienda,
                              style: const TextStyle(fontSize: 24.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TiposCuponPage(
                                          title: 'Seleccione el tipo de cupón',
                                          idCupon: data.id,
                                        )),
                              );
                            },
                          ),
                        );
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
