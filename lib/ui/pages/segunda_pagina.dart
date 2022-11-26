import 'package:flutter/material.dart';
import 'package:flutter_curso_2022/core/models/persona.dart';

class SegundaPaginaArgumentos {
  final Persona? usuario;
  final bool esNuevo;
  SegundaPaginaArgumentos({this.usuario,this.esNuevo = false});
}

class SegundaPagina extends StatefulWidget {
  final Persona? usuario;
  final bool esNuevo;
  const SegundaPagina({super.key,this.usuario,this.esNuevo = false});

  @override
  State<SegundaPagina> createState() => _SegundaPaginaState();
}

class _SegundaPaginaState extends State<SegundaPagina> {
  @override
  Widget build(BuildContext context) {
    SegundaPaginaArgumentos argumentos;
    if(ModalRoute.of(context)?.settings.arguments != null){
      argumentos = ModalRoute.of(context)?.settings.arguments as SegundaPaginaArgumentos;
    } else {
      argumentos = SegundaPaginaArgumentos();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
            //Navigator.of(context).pop();
          },
        ),
        title: const Text('Segunda pagina')
      ),
      body: Container(
        width: double.infinity,
        child: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/cachorros.jpg')
              )
            ),
          ),
          Text(argumentos.usuario?.nombre ?? 'Sin datos', style: TextStyle(fontSize: 20)),
          Text(argumentos.usuario?.edad.toString() ?? 'Sin datos', style: TextStyle(fontSize: 20)),
          Container(
            height: 300,
            width: 300,
            child: Image.network('https://www.dogalize.com/wp-content/uploads/2017/06/La-sverminazione-e-la-pulizia-del-cucciolo-del-cane-2-800x400-800x400.jpg', fit: BoxFit.cover,),
          )
        ],
      ),
      )
    );
  }
}