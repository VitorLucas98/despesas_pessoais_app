import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  final void Function(String, double) onSubmit;

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
              controller: tituloController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              controller: valorController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final String titulo = tituloController.text;
                      final double valor = double.tryParse(valorController.text) ?? 0.0;
                      if (titulo.isEmpty || valor <= 0) {
                        return;
                      }
                      onSubmit(titulo, valor);
                    },
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
