import 'package:flutter/material.dart';

import 'setup_screen_basics.dart';

typedef FormSetupScreenComponentCompletion = void Function(
    BuildContext context);

class FormSetupScreenComponent extends StatefulSetupScreenComponent {
  final List<Widget> children;
  final FormSetupScreenComponentCompletion formSetupScreenComponentCompletion;

  const FormSetupScreenComponent(
      {Key? key,
      required this.children,
      required this.formSetupScreenComponentCompletion})
      : super(key: key);

  @override
  FormSetupScreenComponentState createState() {
    return FormSetupScreenComponentState();
  }
}

class FormSetupScreenComponentState extends State<FormSetupScreenComponent> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: List.from(super.widget.children)
          ..add(
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  super.widget.formSetupScreenComponentCompletion(context);
                }
              },
              child: const Text('Submit'),
            ),
          ),
      ),
    );
  }
}

class TextFormFieldSetupScreenComponent extends TextFormField {
  final Key? key;
  final FormFieldValidator<String> validator;

  TextFormFieldSetupScreenComponent({this.key, required this.validator})
      : super(key: key, validator: validator);
}
