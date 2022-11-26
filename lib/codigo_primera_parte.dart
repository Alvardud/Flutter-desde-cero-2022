import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
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
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.mail, color: Colors.white),
          onPressed: ()async{
            return await showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: const Text("Soy una alerta"),
                  content: const Text("Soy el cuerpo de la alerta")
                );
              }
            );
          },
        ),
        appBar: AppBar(
          title: Text("Titulo de la aplicacion"),
        ),
        body: Center(
          child: CuartoWidget(),
        ),
      ),
    );
  }
}

class CuartoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        TextButton(
          child: const Text("Boton de accion 1", style: TextStyle(
            color: Colors.red,
            fontSize: 30
          )),
          onPressed: ()async{
            return await showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: const Text("Soy una alerta"),
                  content: const Text("Soy el cuerpo de la alerta"),
                  actions: [
                    TextButton(
                      child: Text("Aceptar"),
                      onPressed:(){}
                    )
                  ],
                );
              }
            );
          },
        ),
      ]
    );
  }
}





class TercerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      height: 200,
      width: 200,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      child: Container(),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20)
      )
    );
  }
}


class SegundoWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SegundoWidgetState();
  }
}

class SegundoWidgetState extends State<SegundoWidget>{
  double edad = 20;
  
  late String texto;
  late dynamic color;
  
  @override
  void initState(){
    texto = "hola mi widget variable";
    color = Colors.black;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        color: color,
      )
    );
  }
}
