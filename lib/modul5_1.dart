class Expense {
  final String description;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  // Menghitung nomor minggu dalam tahun (ISO 8601 compliant)
  int getWeekNumber() {
    // Ambil hari pertama tahun ini
    final firstDayOfYear = DateTime(date.year, 1, 1);
    // Hitung jumlah hari sejak awal tahun (0-based)
    final dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    // ISO week: Senin = 1, Minggu = 7
    final weekday = date.weekday; // Senin = 1, ..., Minggu = 7

    // Sesuaikan agar minggu dimulai dari Senin
    // Rumus ISO week number (sederhana, asumsi minggu pertama punya minimal 4 hari di tahun ini)
    final weekNumber = ((dayOfYear - weekday + 10) / 7).floor();
    return weekNumber;
  }

  int getQuarter() {
    return ((date.month - 1) ~/ 3) + 1; // Gunakan ~/ untuk integer division
  }

  bool isWeekend() {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }
}

void main() {
  var expense = Expense(
    description: 'Brunch akhir pekan',
    amount: 45.00,
    category: 'Makanan',
    date: DateTime(2025, 10, 11), // Sabtu
  );

  print('Kuartal: ${expense.getQuarter()}');      // Output: 4
  print('Akhir pekan? ${expense.isWeekend()}');   // Output: true
  print('Minggu ke-: ${expense.getWeekNumber()}'); // Contoh output: 41
}