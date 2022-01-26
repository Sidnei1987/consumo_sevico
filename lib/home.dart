import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

   TextEditingController _controllerCep = TextEditingController();
  String _resultado = "Resultado";

  _recuperaCep() async {

    String cep = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;

    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

      setState(() {
        _resultado = "${logradouro}, ${complemento}";
      });

    print(
        "Resposta logradouro: ${logradouro} Resposta complemento: ${complemento} Resposta bairro: ${bairro}Resposta localidade: ${localidade}");


    //print("Resposta" + response.statusCode.toString());
    // print("Resposta" + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
             keyboardType: TextInputType.number,
             decoration: InputDecoration(
               labelText: "Digite o cep:  ex: 03244000"
             ),
             style: TextStyle(
               fontSize: 20,
             ),
             controller: _controllerCep,
           ),
            ElevatedButton(
              onPressed: _recuperaCep,
              child: Text("Clique aqui"),
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
