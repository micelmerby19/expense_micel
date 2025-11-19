// Kelas abstrak PaymentMethod
abstract class PaymentMethod {
  String get name;
  String get icon;

  bool validate();
  void processPayment(double amount);
  void showReceipt(double amount) {
    print('✅ Pembayaran berhasil!');
    print('Jumlah: \$${amount.toStringAsFixed(2)}');
    print('Metode: $name');
  }
}

// Kelas Cryptocurrency
class Cryptocurrency extends PaymentMethod {
  final String walletAddress;
  final String coinType;

  Cryptocurrency({
    required this.walletAddress,
    required this.coinType,
  });

  @override
  String get name => 'Dompet $coinType';

  @override
  String get icon => '₿';

  @override
  bool validate() {
    return walletAddress.isNotEmpty && walletAddress.length > 20;
  }

  @override
  void processPayment(double amount) {
    if (!validate()) {
      print('❌ Alamat wallet tidak valid');
      return;
    }

    print('$icon Memproses pembayaran $coinType...');
    print('Wallet: ${walletAddress.substring(0, 6)}...${walletAddress.substring(walletAddress.length - 4)}');
    print('⏳ Menunggu konfirmasi blockchain...');
    showReceipt(amount);
  }
}

// Kelas Expense
class Expense {
  final String description;
  final double amount;
  final String category;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
  });

  void payWith(PaymentMethod method) {
    print('Mencoba membayar: "$description" sebesar \$${amount.toStringAsFixed(2)} via ${method.name}');
    method.processPayment(amount);
  }
}

// Fungsi main
void main() {
  var btc = Cryptocurrency(
    walletAddress: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
    coinType: 'Bitcoin',
  );

  var expense = Expense(
    description: 'Pembelian online',
    amount: 250.0,
    category: 'Belanja',
  );

  expense.payWith(btc);
}