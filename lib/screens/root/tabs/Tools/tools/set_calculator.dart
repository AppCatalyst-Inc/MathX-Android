import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/SetCalculatorLogic.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

class SetCalculatorPage extends StatefulWidget {
  @override
  _SetCalculatorPageState createState() => _SetCalculatorPageState();
}

class _SetCalculatorPageState extends State<SetCalculatorPage> {
  setEvalType calculator = setEvalType.union;
  TextFieldListController controller = TextFieldListController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Set Calculator"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  controller.addNewField();
                });
                formKey.currentState?.validate();
              },
              icon: const Icon(Icons.add),
            )
          ],
          bottom: TabBar(
            tabs: const [
              Tab(text: "Union"),
              Tab(text: "Intersection"),
            ],
            onTap: (val) {
              setState(() {
                calculator =
                    val == 0 ? setEvalType.union : setEvalType.intersection;
              });
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: _buildResult(calculateResult()),
                ),
                TextFieldList(
                  controller: controller,
                  formKey: formKey,
                  nameBuilder: (total, index) {
                    return "Set ${index + 1}";
                  },
                  validators: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChange: (_) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResult(String result) {
    final isValid = formKey.currentState?.isValid ?? false;
    final hasEnoughSets = controller.textFieldValues.length >= 2;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              calculator == setEvalType.union ? "Union" : "Intersection",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (!hasEnoughSets)
              const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber),
                    SizedBox(width: 10),
                    AutoSizeText(
                      "Please make sure there are at least 2 sets",
                      minFontSize: 5,
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            else if (!isValid)
              const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber),
                    SizedBox(width: 10),
                    AutoSizeText(
                      "Please make sure all sets are entered",
                      minFontSize: 5,
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            else if (result.isNotEmpty)
              Text(
                result,
                style: const TextStyle(fontSize: 18),
              )
            else
              const Text(
                "No values in the intersection",
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }

  String calculateResult() {
    final values = controller.textFieldValues;
    if (values.length < 2) {
      return '';
    }

    final setList = values.map((value) => value.split(', ')).toList();
    final resultSet = calculator == setEvalType.union
        ? calculateUnion(setList)
        : calculateIntersection(setList);

    return resultSet.join(', ');
  }
}
