import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TransactionType {
  income,
  expense,
}

class FinancialManagement extends StatefulWidget {
  @override
  _FinancialManagementState createState() => _FinancialManagementState();
}

class _FinancialManagementState extends State<FinancialManagement> {
  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  final List<Transaction> transactions = [];
  double totalBalance = 0;
  double income = 0;
  double expenses = 0;
  DateTime selectedDate = DateTime.now();

  void updateFinancialSummary() {
    double newIncome = 0;
    double newExpenses = 0;

    for (var transaction in transactions) {
      if (transaction.amount > 0) {
        newIncome += transaction.amount;
      } else {
        newExpenses += transaction.amount.abs();
      }
    }

    setState(() {
      income = newIncome;
      expenses = newExpenses;
      totalBalance = newIncome - newExpenses;
    });
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Financial Management'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with green background
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 180, // Reduced height to accommodate the card
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D32),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selamat Datang',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Figo Razzan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: _pickDate,
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat('dd MMMM yyyy')
                                        .format(selectedDate),
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Spacer for the card
                  SizedBox(height: 100),

                  // Transactions section
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riwayat Transaksi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...transactions.map((transaction) =>
                            _buildTransactionItem(transaction)),
                      ],
                    ),
                  ),
                ],
              ),

              // Floating balance card
              Positioned(
                top:
                    130, // Adjust this value to control how much the card overlaps
                left: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Saldo',
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 8),
                      Text(
                        currencyFormatter.format(totalBalance),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFinancialInfo(
                            icon: Icons.arrow_downward,
                            label: 'Pemasukan',
                            amount: income,
                            color: Colors.green,
                          ),
                          _buildFinancialInfo(
                            icon: Icons.arrow_upward,
                            label: 'Pengeluaran',
                            amount: expenses,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _pickDate,
            backgroundColor: Colors.blue,
            child: Icon(Icons.calendar_today),
            heroTag: "pickDateButton",
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _showAddTransactionDialog(context),
            backgroundColor: Colors.green,
            child: Icon(Icons.add),
            heroTag: "addTransactionButton",
          ),
        ],
      ),
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    TransactionType transactionType = TransactionType.income;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Tambah Transaksi'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama Transaksi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Jumlah',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<TransactionType>(
                    value: transactionType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: TransactionType.income,
                        child: Row(
                          children: [
                            Icon(Icons.arrow_downward, color: Colors.green),
                            SizedBox(width: 10),
                            Text(
                              'Pemasukan',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: TransactionType.expense,
                        child: Row(
                          children: [
                            Icon(Icons.arrow_upward, color: Colors.red),
                            SizedBox(width: 10),
                            Text(
                              'Pengeluaran',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (TransactionType? value) {
                      if (value != null) {
                        setState(() {
                          transactionType = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        amountController.text.isNotEmpty) {
                      double amount =
                          double.tryParse(amountController.text) ?? 0;
                      if (transactionType == TransactionType.expense) {
                        amount = -amount;
                      }

                      setState(() {
                        transactions.add(
                          Transaction(
                            name: nameController.text,
                            date:
                                DateFormat('dd MMM yyyy').format(selectedDate),
                            amount: amount,
                            icon: nameController.text[0],
                            iconColor: amount > 0 ? Colors.green : Colors.red,
                          ),
                        );
                      });

                      updateFinancialSummary();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Tambah'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFinancialInfo({
    required IconData icon,
    required String label,
    required double amount,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            Text(
              currencyFormatter.format(amount),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: transaction.iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                transaction.icon,
                style: TextStyle(
                  color: transaction.iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  transaction.date,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            currencyFormatter.format(transaction.amount),
            style: TextStyle(
              color: transaction.amount > 0 ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class Transaction {
  final String name;
  final String date;
  final double amount;
  final String icon;
  final Color iconColor;

  Transaction({
    required this.name,
    required this.date,
    required this.amount,
    required this.icon,
    required this.iconColor,
  });
}
