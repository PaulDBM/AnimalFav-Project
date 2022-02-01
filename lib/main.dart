import 'dart:convert';
//import 'dart:developer';

import 'package:animal_fav/models/evento.dart';
import 'package:animal_fav/models/recorrido.dart';
import 'package:animal_fav/pages/cupones.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimalFav Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'AnimalFav'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<EventoA>> eventos;
  late Future<List<RecorridoA>> recorridos;
  final cuponesListKey = GlobalKey<_MyHomePageState>();

  @override
  void initState() {
    super.initState();
    eventos = getEventos();
    recorridos = getRecorridos();
  }

  Future<List<RecorridoA>> getRecorridos() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/api/recorrido"));
    List<RecorridoA> recorridos;
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      recorridos = items.map<RecorridoA>((json) {
        return RecorridoA.fromJson(json);
      }).toList();
      //log(recorridos.toString());
    } else {
      recorridos = [];
    }
    return recorridos;
  }

  Future<List<EventoA>> getEventos() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/api/evento"));
    List<EventoA> eventos;
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      eventos = items.map<EventoA>((json) {
        return EventoA.fromJson(json);
      }).toList();
      //log(eventos.toString());
    } else {
      eventos = [];
    }
    return eventos;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        key: cuponesListKey,
        appBar: AppBar(
            title: const Text(
              'AnimalFav',
              style: TextStyle(fontSize: 18.0),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                              title: 'AnimalFav',
                            )),
                  );
                },
                child: const Text('Home'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Evento()),
                  );
                },
                child: const Text('Eventos'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Recorrido()),
                  );
                },
                child: const Text('Recorridos'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CuponesPage(
                              title: 'Cupones disponibles',
                            )),
                  );
                },
                child: const Text('Cupones'),
              ),
            ]),
        body: SingleChildScrollView(
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'AnimalFav',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Eventos",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        ),
                      ]),
                ),
                FutureBuilder<List<EventoA>>(
                  future: eventos,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData)
                      return const CircularProgressIndicator();
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              "Patrocinador: " +
                                  data.nombre +
                                  "\n" +
                                  "Correo: " +
                                  data.correo +
                                  "\n" +
                                  "Ubicación: " +
                                  data.ubicacion +
                                  "\n" +
                                  "Dia: " +
                                  data.dia +
                                  "\n" +
                                  "Duración: " +
                                  data.duracion,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Recorridos",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        ),
                      ]),
                ),
                FutureBuilder<List<RecorridoA>>(
                  future: recorridos,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData)
                      return const CircularProgressIndicator();
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              "Patrocinador: " +
                                  data.nombre +
                                  "\n" +
                                  "Correo: " +
                                  data.correo +
                                  "\n" +
                                  "Ubicación: " +
                                  data.ubicacion +
                                  "\n" +
                                  "Dia: " +
                                  data.dia +
                                  "\n" +
                                  "Duración: " +
                                  data.duracion +
                                  "\n" +
                                  "Descripción del recorrido: " +
                                  data.descRecorrido,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent), label: 'Soporte'),
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_vertical_circle), label: 'Cambiar')
        ]));
  }
}

Future<http.Response> crearEvento(nombre, correo, dia, duracion, ubicacion) {
  return http.post(
    Uri.parse("http://10.0.2.2:8000/api/evento/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({
      'nombre': nombre.text,
      'correo': correo.text,
      'dia': dia.text,
      'duracion': duracion.text,
      'ubicacion': ubicacion.text
    }),
  );
}

Future<http.Response> crearRecorrido(
    nombre, correo, dia, duracion, ubicacion, descRecorrido) {
  return http.post(
    Uri.parse("http://10.0.2.2:8000/api/evento/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({
      'nombre': nombre.text,
      'correo': correo.text,
      'dia': dia.text,
      'duracion': duracion.text,
      'ubicacion': ubicacion.text,
      'descRecorrido': descRecorrido.text,
    }),
  );
}

class Evento extends StatelessWidget {
  const Evento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final correoController = TextEditingController();
    final diaController = TextEditingController();
    final duracionController = TextEditingController();
    final ubicacionController = TextEditingController();

    return Scaffold(
        appBar:
            AppBar(title: const Text('Creación de Eventos'), actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: 'AnimalFav',
                        )),
              );
            },
            child: const Text('Home'),
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Evento()),
              );
            },
            child: const Text('Eventos'),
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Recorrido()),
              );
            },
            child: const Text('Recorridos'),
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CuponesPage(
                          title: 'AnimalFav',
                        )),
              );
            },
            child: const Text('Cupones'),
          ),
        ]),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Formulario de Evento'),
                  TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Correo Electrónico'),
                      controller: correoController),
                  TextField(
                      controller: nombreController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nombre Evento')),
                  TextField(
                      controller: diaController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Dia y Hora (aaaa-mm-ddTHH:MM:SS)')),
                  TextField(
                      controller: duracionController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '60 minutos')),
                  TextField(
                      controller: ubicacionController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ubicación del Evento')),
                  TextButton(
                    onPressed: () {
                      crearEvento(
                          nombreController,
                          correoController,
                          diaController,
                          duracionController,
                          ubicacionController);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Datos Enviados')));
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent), label: 'Soporte'),
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_vertical_circle), label: 'Cambiar')
        ]));
  }
}

class Recorrido extends StatelessWidget {
  const Recorrido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final correoController = TextEditingController();
    final diaController = TextEditingController();
    final duracionController = TextEditingController();
    final ubicacionController = TextEditingController();
    final descRecorridoControler = TextEditingController();

    return Scaffold(
        appBar: AppBar(title: Text('Creación de Recorridos'), actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: 'AnimalFav',
                        )),
              );
            },
            child: const Text('Home'),
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Evento()),
              );
            },
            child: const Text('Eventos'),
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Recorrido()),
              );
            },
            child: const Text('Recorridos'),
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CuponesPage(
                          title: 'AnimalFav',
                        )),
              );
            },
            child: const Text('Cupones'),
          ),
        ]),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Formulario de Evento'),
                  const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Correo Electrónico')),
                  const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nombre del Recorrido')),
                  const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Dia y Hora (dd-mm-aaaa HH:MM:SS)')),
                  const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ubicación del Recorrido')),
                  const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Descripción del Recorrido')),
                  TextButton(
                    onPressed: () {
                      crearRecorrido(
                          nombreController,
                          correoController,
                          diaController,
                          duracionController,
                          ubicacionController,
                          descRecorridoControler);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Datos Enviados')));
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent), label: 'Soporte'),
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_vertical_circle), label: 'Cambiar')
        ]));
  }
}
