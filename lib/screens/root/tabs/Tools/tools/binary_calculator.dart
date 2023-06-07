import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/logic/tools/BinaryCalculatorLogic.dart';

class BinaryConverterPage extends StatefulWidget {
  const BinaryConverterPage({super.key});

  @override
  _BinaryConverterPageState createState() => _BinaryConverterPageState();
}

class _BinaryConverterPageState extends State<BinaryConverterPage> {
  String inputString = "";
  NumberCases inputSelection = NumberCases.decimal;
  NumberCases inputNumberCase = NumberCases.decimal;

  String decimalResults = "0";
  String binaryResults = "0";
  String bcdResults = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Binary Converter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildResults(),
            FormBuilderDropdown<NumberCases>(
              name: "selector",
              initialValue: inputSelection,
              items: NumberCases.values.map((numberCase) {
                return DropdownMenuItem<NumberCases>(
                  value: numberCase,
                  child: Text(numberCase.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  inputSelection = value!;
                  inputNumberCase = value;
                  update();
                });
              },
            ),
            const SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                labelText: "${inputNumberCase.name} number",
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  inputString = value;
                  update();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResults() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            if (inputNumberCase != NumberCases.decimal)
              ListTile(
                title: const Text("Decimal:"),
                trailing: Text(decimalResults),
              ),
            if (inputNumberCase != NumberCases.binary)
              ListTile(
                title: const Text("Binary:"),
                trailing: Text(binaryResults),
              ),
            if (inputNumberCase != NumberCases.bcd)
              ListTile(
                title: const Text("BCD:"),
                trailing: Text(bcdResults),
              ),
          ],
        ),
      ),
    );
  }

  void update() {
    if (inputNumberCase == NumberCases.bcd) {
      inputString = formatInputToBCD(inputString);
    } else {
      inputString = inputString.replaceAll(" ", "");
    }

    if (inputString.isNotEmpty) {
      decimalResults = convertToDecimal(inputString, inputNumberCase);
      binaryResults = convertToBinary(inputString, inputNumberCase);
      bcdResults = convertToBCD(inputString, inputNumberCase);
    } else {
      decimalResults = "0";
      binaryResults = "0";
      bcdResults = "0";
    }
  }
}
