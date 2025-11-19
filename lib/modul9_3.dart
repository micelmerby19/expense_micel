class BudgetManager {
  // Menyimpan budget dan pengeluaran per kategori
  final Map<String, double> _budgets = {};
  final Map<String, double> _expenses = {};

  // Set budget bulanan per kategori
  void setBudget(String category, double amount) {
    if (amount < 0) {
      print('❌ Budget tidak boleh negatif.');
      return;
    }
    _budgets[category] = amount;
    _expenses.putIfAbsent(category, () => 0.0);
    print('✅ Budget untuk "$category": \$${amount.toStringAsFixed(2)}');
  }

  // Lacak pengeluaran
  void recordExpense(String category, double amount) {
    if (amount <= 0) {
      print('❌ Jumlah pengeluaran harus lebih dari 0.');
      return;
    }

    if (!_budgets.containsKey(category)) {
      print('❌ Kategori "$category" belum memiliki budget. Silakan set terlebih dahulu.');
      return;
    }

    _expenses[category] = (_expenses[category] ?? 0.0) + amount;

    double currentExpense = _expenses[category]!;
    double budget = _budgets[category]!;

    // Tampilkan warning jika mendekati atau melebihi limit
    double remaining = budget - currentExpense;
    double percentageUsed = (currentExpense / budget) * 100;

    if (percentageUsed >= 90) {
      print('⚠ PERINGATAN: Anda telah menggunakan ${percentageUsed.toStringAsFixed(1)}% dari budget "$category"!');
      if (remaining < 0) {
        print('🚨 MELEBIHI BUDGET! Melebihi \$${(-remaining).toStringAsFixed(2)}');
      } else {
        print('💰 Sisa budget: \$${remaining.toStringAsFixed(2)}');
      }
    } else {
      print('📈 Pengeluaran "$category": \$${currentExpense.toStringAsFixed(2)} / \$${budget.toStringAsFixed(2)}');
    }
  }

  // Generate laporan budget
  void generateReport() {
    print('\n📊 LAPORAN BUDGET BULANAN');
    print('-' * 40);

    for (var category in _budgets.keys) {
      double budget = _budgets[category]!;
      double expense = _expenses[category] ?? 0.0;
      double remaining = budget - expense;
      double percentageUsed = budget > 0 ? (expense / budget) * 100 : 0;

      String status = '';
      if (expense == 0) {
        status = '🟢 Belum ada pengeluaran';
      } else if (percentageUsed >= 100) {
        status = '🔴 MELEBIHI BUDGET';
      } else if (percentageUsed >= 80) {
        status = '🟡 Mendekati limit';
      } else {
        status = '🔵 Aman';
      }

      print(
          '$category: \$${expense.toStringAsFixed(2)} / \$${budget.toStringAsFixed(2)} ($percentageUsed.toStringAsFixed(1)%) — $status');
      if (remaining < 0) {
        print('   ⚠ Melebihi: \$${(-remaining).toStringAsFixed(2)}');
      } else {
        print('   💰 Sisa: \$${remaining.toStringAsFixed(2)}');
      }
      print('');
    }

    // Total keseluruhan
    double totalBudget = _budgets.values.reduce((a, b) => a + b);
    double totalExpense = _expenses.values.reduce((a, b) => a + b);
    double totalRemaining = totalBudget - totalExpense;

    print('-' * 40);
    print('TOTAL: \$${totalExpense.toStringAsFixed(2)} / \$${totalBudget.toStringAsFixed(2)}');
    if (totalRemaining < 0) {
      print('🚨 TOTAL MELEBIHI BUDGET: \$${(-totalRemaining).toStringAsFixed(2)}');
    } else {
      print('💰 TOTAL SISA: \$${totalRemaining.toStringAsFixed(2)}');
    }
  }
}