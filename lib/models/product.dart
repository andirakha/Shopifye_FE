class Product {
  final int id;
  final String nama;
  final int harga;
  final String kategori;
  final String photo;

  Product({
    required this.id,
    required this.nama,
    required this.harga,
    required this.kategori,
    required this.photo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] ?? 0,
        nama: json['nama'] ?? '',
        harga: json['harga'] ?? 0,
        kategori: json['kategori'] ?? '',
        photo: json['photo'] ?? '');
  }
}
