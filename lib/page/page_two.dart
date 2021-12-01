import 'package:curr_ru_us/services/api.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  ApiClient client = ApiClient();

  List<String> currencies;

  @override
  void initState() {
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        title: const Text(
          "Currency Converter",
          style: TextStyle(
            fontSize: 26.0,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      currencies[index],
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: currencies.length,
      ),
    );
  }
}
