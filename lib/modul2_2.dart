void main() {
  // Contoh data expense
  Expense expense1 = Expense(DateTime.now().subtract(Duration(days: 3)), 'Makanan');
  Expense expense2 = Expense(DateTime(2023, 9, 10), 'Transportasi');

  // Tes method-method
  print('Expense1 isThisMonth: ${expense1.isThisMonth()}'); // true (kalau bulan ini)
  print('Expense1 isFood: ${expense1.isFood()}');           // true
  print('Expense1 getDaysAgo: ${expense1.getDaysAgo()}');   // 3

  print('Expense2 isThisMonth: ${expense2.isThisMonth()}'); // false
  print('Expense2 isFood: ${expense2.isFood()}');           // false
  print('Expense2 getDaysAgo: ${expense2.getDaysAgo()}');   // jumlah hari dari 2023-09-10
}

class Expense {
  DateTime date;
  String category;

  Expense(this.date, this.category);

  bool isThisMonth() {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  bool isFood() {
    return category == 'Makanan';
  }

  int getDaysAgo() {
    DateTime now = DateTime.now();
    return now.difference(date).inDays;
  }
}