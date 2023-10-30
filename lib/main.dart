import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CurrencyConverter(title: 'Currency Converter'),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key, required this.title});

  final String title;

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double amount = 0.0;
  double convertedAmount = 0.0;
  String selectedCurrency = 'USD';

  Map<String, double> exchangeRates = {
    'USD': 0.00024 ,
    'EUR': 0.00023 ,
    'BS': 0.0085 ,
  };

  void convertCurrency() {
    setState(() {
      convertedAmount = amount * exchangeRates[selectedCurrency]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = double.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Cantidad en pesos colombianos (COP)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedCurrency,
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                });
              },
              items: exchangeRates.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertCurrency,
              child: const Text('Convertir'),
            ),
            const SizedBox(height: 20),
            Text(
              'la Cantidad Convertida a $selectedCurrency es de: ${convertedAmount.toStringAsFixed(2)} $selectedCurrency',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
