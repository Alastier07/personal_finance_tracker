import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/transaction/transaction_bloc.dart';
import '../blocs/transaction/transaction_event.dart';
import '../core/utils/date_time_utils.dart';
import '../data/model/transaction_model.dart';
import '../widgets/date_picker_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  static const String routeName = '/add-expense';

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController(text: '0');
  final _dateController = TextEditingController(
    text: defaultDateFormat(DateTime.now()),
  );
  DateTime _dateTime = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _dateController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Expense'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: SizedBox(
                height: 480,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Widget
                          const Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          // Widget
                          const Text(
                            'Amount',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.parse(value) == 0) {
                                return 'Please enter some value';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          // Widget
                          const Text(
                            'Date',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          DatePickerWidget(
                            controller: _dateController,
                            dateSelected: (date) =>
                                _dateTime = date ?? _dateTime,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;

                                context.read<TransactionBloc>().add(
                                      AddTransaction(
                                        transaction: TransactionModel(
                                          name: _nameController.text,
                                          amount: double.tryParse(
                                                  _amountController.text) ??
                                              0,
                                          date: _dateTime,
                                          type: TransactionType.expense,
                                        ),
                                      ),
                                    );
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
