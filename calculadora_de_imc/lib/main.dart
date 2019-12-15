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
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var _infoText = "Informe seus Dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
    _infoText = "Informe seus Dados!";
    _formkey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      print(imc);

      if (imc < 18.6)
        _infoText = "Abaixo do Peso: ${imc.toStringAsPrecision(4)}";
      else if (imc >= 18.6 && imc < 24.9)
        _infoText = "Peso Ideal: ${imc.toStringAsPrecision(4)}";
      else if (imc >= 24.8 && imc < 29.9)
        _infoText ="Peso Levemente Acima do Peso: ${imc.toStringAsPrecision(4)}";
      else if (imc >= 29.9 && imc < 34.9)
        _infoText = "Obesidade I: ${imc.toStringAsPrecision(4)}";
      else if (imc >= 34.9 && imc < 39.9)
        _infoText = "Peso Levemente Acima do Peso: ${imc.toStringAsPrecision(4)}";
      else if (imc >= 40)
        _infoText ="Peso Levemente Acima do Peso: ${imc.toStringAsPrecision(4)}";
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key:_formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 150.0,
                  color: Colors.indigo,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.indigo),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo),
                  controller: weightController,
                  validator:(value){
                    if(value.isEmpty)
                    return "Insira seu Peso!";
                    else if (int.parse(value) > 120 )
                      return "Peso inválido!";

                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.indigo)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo),
                  controller: heightController,
                  validator:(value){
                    if(value.isEmpty)
                      return "Insira sua Altura!";

                    else if (int.parse(value) < 110 ||int.parse(value) > 300 )
                      return "Altura inválido!";

                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      child: Text(
                        "Calcular!",
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                      onPressed: (){
                        if(_formkey.currentState.validate())
                          _calculate();
                      },
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Text(_infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.indigo, fontSize: 25.0)),
              ],
            ),
          ),
        ));
  }
}
