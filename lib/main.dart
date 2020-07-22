import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controlerAltura = TextEditingController();
  TextEditingController controlerPeso = TextEditingController();
  String info = "Informe seus dados.";

  GlobalKey<FormState> _forKey = GlobalKey<FormState>();

  void _resetFields() {
    controlerAltura.text = "";
    controlerPeso.text = "";
    setState(() {
      info = "Informe seus dados.";
      _forKey = GlobalKey<FormState>();
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(controlerPeso.text);
      double altura = double.parse(controlerAltura.text);
      double imc = peso / ((altura / 100) * (altura / 100));
      if (imc < 18.6) {
        info = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        info = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        info = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        info = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        info = "Obesidade grau II(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40)
        info = "Obesidade grau III (${imc.toStringAsPrecision(4)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _forKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline,
                    size: 120.0, color: Colors.indigoAccent),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg):",
                      labelStyle: TextStyle(color: Colors.indigo)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                  controller: controlerPeso,
                  validator: (value) {
                    if (value.isEmpty) return "Insira seu peso!";
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm):",
                      labelStyle: TextStyle(color: Colors.indigo)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                  controller: controlerAltura,
                  validator: (value) {
                    if (value.isEmpty) return "Insira sua altura";
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.indigo,
                      onPressed: (){
                        if(_forKey.currentState.validate()){
                          _calcularIMC();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
