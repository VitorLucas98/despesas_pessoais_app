import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  final void Function(String, double) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final tituloController = TextEditingController();

  final valorController = TextEditingController();

  _submitForm() {
    final String titulo = tituloController.text;
    final double valor = double.tryParse(valorController.text) ?? 0.0;
    if (titulo.isEmpty || valor <= 0) {
      return;
    }
    widget.onSubmit(titulo, valor);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
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
    );
  }
}
