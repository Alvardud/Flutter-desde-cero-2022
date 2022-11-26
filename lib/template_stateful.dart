import "package:flutter/material.dart";

class NombrePagina extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NombrePaginaState();
  }
}

class NombrePaginaState extends State<NombrePagina>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Hola"),
      ),
      body: Container(),
    );
  }
}



