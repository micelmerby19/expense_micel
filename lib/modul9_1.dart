class CategoryManager {
  // Ubah dari final ke var agar bisa dimodifikasi
  List<String> _categories = ['Makanan', 'Transportasi', 'Tagihan'];

  void addCategory(String category) {
    if (category.isNotEmpty && !_categories.contains(category)) {
      _categories.add(category);
      print('✅ Kategori "$category" berhasil ditambahkan.');
    } else {
      print('❌ Kategori "$category" sudah ada atau kosong.');
    }
  }

  void removeCategory(String category) {
    if (_categories.remove(category)) {
      print('✅ Kategori "$category" berhasil dihapus.');
    } else {
      print('❌ Kategori "$category" tidak ditemukan.');
    }
  }

  // Getter untuk mendapatkan daftar kategori (tidak bisa diubah dari luar)
  List<String> get allCategories => List.unmodifiable(_categories);
}