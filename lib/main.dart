import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_curso_2022/ui/pages/primera_pagina.dart';
import 'package:flutter_curso_2022/ui/pages/segunda_pagina.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main()async {
  await Hive.initFlutter();
  await Hive.openBox('hiveStore');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        'primera_pagina': (context)=> FormularioPagina(),
        'segunda_pagina': (context)=> SegundaPagina()
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Formulario"),
        ),
        body: Center(
          child: FormularioPagina(),
        ),
      ),
    );
  }
}
