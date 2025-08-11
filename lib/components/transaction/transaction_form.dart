import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _selectedDate = selectedDate;
        });
      }
    });
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
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                onSubmitted: (_) => _submitForm(),
                controller: tituloController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                controller: valorController,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null 
                        ? 'Nenhum data selecionado'
                        : "Data Selecionada: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    TextButton( 
                    child: const Text(
                      'Selecionar Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDatePicker)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Adicionar Transação'),
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
