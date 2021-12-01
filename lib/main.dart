import 'package:curr_ru_us/page/page_two.dart';
import 'package:curr_ru_us/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curr_ru_us/services/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  ApiClient client = ApiClient();

  List<String> currencies;

  String from = "RUB";
  String to = "USD";

  String result = "";
  @override
  void initState() {
    super.initState();
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          key: _formKey,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              onSubmitted: (value) async {
                double rate = await client.getRate(from, to);
                setState(() {
                  result = (rate * double.parse(value)).toStringAsFixed(3);
                });
              },
              decoration: InputDecoration(
                fillColor: Colors.blue[500],
                labelText: "Input value to convert from $from to $to",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                  color: Colors.blue[500],
                ),
              ),
              style: TextStyle(
                color: Colors.blue[500],
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                customDropDown(currencies, from, (val) {
                  setState(() {
                    from = val;
                  });
                }),
                Expanded(
                  child: FloatingActionButton(
                    onPressed: () {
                      String temp = from;
                      setState(() {
                        from = to;
                        to = temp;
                      });
                    },
                    child: const Icon(
                      Icons.swap_horiz,
                      color: Colors.blue,
                      size: 28.0,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ),
                ),
                customDropDown(currencies, to, (val) {
                  setState(() {
                    to = val;
                  });
                }),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.blue[500],
                  width: 3.0,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Result",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    result,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SecondPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                  ),
                  child: const Icon(
                    Icons.trending_flat,
                    color: Colors.blue,
                    size: 50.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
