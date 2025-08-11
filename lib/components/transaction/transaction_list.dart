import 'package:despesas_pessoais_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.onRemove, {super.key});

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  String _formatCurrency(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
          builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.05),
                Text(
                  'Nenhuma transação cadastrada!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          },
        )
        : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            final tr = transactions[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text(
                        _formatCurrency(tr.value),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  tr.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  DateFormat('d MMM y').format(tr.date),
                ),
                trailing: MediaQuery.of(context).size.width > 480 
                ? TextButton.icon(
                  onPressed: () => onRemove(tr.id),
                  icon: const Icon(Icons.delete),
                  label: const Text('Excluir'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                ) 
                : IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => onRemove(tr.id),
                ),
              ),
            );
          },
        );
  }
}
