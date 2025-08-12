import 'package:despesas_pessoais_app/components/components_adaptatives/button.dart';
import 'package:despesas_pessoais_app/components/components_adaptatives/data_picker.dart';
import 'package:despesas_pessoais_app/components/components_adaptatives/text_field.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final tituloController = TextEditingController();

  final valorController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final String titulo = tituloController.text;
    final double valor = double.tryParse(valorController.text) ?? 0.0;
    if (titulo.isEmpty || valor <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(titulo, valor, _selectedDate!);
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptiveTextField(
                'Título',
                (_) => _submitForm(),
                tituloController,
                false
                ),
              AdaptiveTextField(
                'Valor (R\$)',
                (_) => _submitForm(),
                valorController,
                true
              ),
              AdaptativeDatePicker(
                _selectedDate,
                (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdaptativeButton(
                      'Nova Transação',
                      _submitForm,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
