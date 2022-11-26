import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_curso_2022/core/controllers/persona_controller.dart';
import 'package:flutter_curso_2022/core/models/persona.dart';
import 'package:flutter_curso_2022/ui/pages/segunda_pagina.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class FormularioPagina extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FormularioPaginaState();
  }
}


class FormularioPaginaState extends State<FormularioPagina>{
  
  final _formKey = GlobalKey<FormState>();
  
  List<String> paises = ['Bolivia', 'Peru', 'Colombia', 'Argentina'];

  //textField
  late TextEditingController _controller;
  late TextEditingController _controller2;
  
  late bool seleccionado;
  late String carrera;
  late String? pais;
  late String respuesta;

  final Persona persona = Persona(nombre: 'Alvaro Martinez', edad: 25);

  final hiveStore = Hive.box('hiveStore');
  late final SharedPreferences preferencesStore;

  void initSharedPreferences()async{
    preferencesStore = await SharedPreferences.getInstance();
    var carreraPrefs = preferencesStore.getString('carrera') ?? '';
    setState(() {
      carrera = carreraPrefs;
    });
  }

  @override
  initState(){
    initSharedPreferences();
   _controller = TextEditingController(text: hiveStore.get('nombre'));
   _controller2 = TextEditingController(text: hiveStore.get('edad'));
   seleccionado = false;
   carrera = '';
   pais = null;
   respuesta = '';
   super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej. Alvaro',
                label: Text('Nombre completo')
              ),
              validator: (value){
                if(value==null || value.isEmpty || value==''){
                  return 'El campo nombre es obligatorio';
                }
                return null;
              }
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _controller2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej. 10',
                label: Text('Edad'),
              ),
              onChanged: (valor){
                print("Esta es mi edad $valor");
              },
              validator: (value){
                if(value==null || value.isEmpty || value==''){
                  return 'El campo edad es obligatorio';
                }
                return null;
              }
            ),
            ListTile(
              title: const Text("Eres nuevo programador"),
              subtitle: const Text("Seleccion si eres nuevo programando"),
              leading: Checkbox(
                value: seleccionado,
                onChanged: (value){
                  //actualizar estados
                  setState((){
                    if(value!=null){
                      seleccionado = value;
                    }
                  });
                }
              ),
            ),
            const Text("Selecciona tu carrera"),
              ListTile(
                title: const Text("Informatica"),
                trailing: Radio(
                  groupValue: carrera,
                  value: 'Informatica',
                  onChanged: (value){
                    setState((){
                    if(value!=null){
                        carrera = value;
                      }
                    });
                  }
                )
              ),
              ListTile(
                title: const Text("Electronica"),
                trailing: Radio(
                  groupValue: carrera,
                  value: 'Electronica',
                  onChanged: (value){
                    setState((){
                    if(value!=null){
                        carrera = value;
                      }
                    });
                  }
                )
              ),
            const Text("Selecciona tu pais"),
            DropdownButton<String>(
              value: pais,
              items: paises.map<DropdownMenuItem<String>>((String item){
                return DropdownMenuItem(
                  value: item,
                  child: Text(item)
                );
              }).toList(),
              onChanged: (String? value){
                setState((){
                  if(value!=null){
                    pais = value;
                  }
                });
              }
            ),
            Row(
              children: [
                TextButton(
                  child: const Text("Validar"),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      if(carrera==''){
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Debes seleccionar una carrera")
                        )
                      );
                      }else {
                        hiveStore.put('nombre', _controller.value.text);
                        hiveStore.put('edad', _controller2.value.text);
                        preferencesStore.setString('carrera', carrera);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Datos almacenados correctamente")
                          )
                        );
                      }
                    }
                  }
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  child: const Text("Segundo"),
                  onPressed: (){}
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  child: const Text("Tercero"),
                  onPressed: (){
                    // Navigator.push(context, 
                    //   MaterialPageRoute(
                    //     builder: (context)=> SegundaPagina(
                    //       usuario: persona,
                    //       esNuevo: seleccionado,
                    //     )
                    // ));

                    final controlador = PersonaController(persona);
                    controlador.cambiarNombre('Rodrigo Martinez');

                    Navigator.pushNamed(context, 'segunda_pagina',
                    arguments: SegundaPaginaArgumentos(
                      usuario: persona
                    ));
                  }
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: const Text("Cuarto")
                  ),
                  onTap: ()async{
                    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
                    var respuestaPeticion = await http.get(url);
                    var json = jsonDecode(respuestaPeticion.body);
                    setState(() {
                      respuesta = json['title'];
                    });
                  },
                  onLongPress: (){
                    print("Presionado largo");
                  },
                  onDoubleTap: (){
                    print("Doble presionado");
                  }
                ),
              ]
            ),
            Text(respuesta)
          ]
        )
      )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    hiveStore.close();
    super.dispose();
  }
}