class Product {
  final String barcode;
  final String photo;
  final String name;
  final double price;
  final String description;
  final List<String> categories;

  Product({
    required this.barcode,
    required this.photo,
    required this.name,
    required this.price,
    required this.description,
    required this.categories,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      barcode: data['barcode'],
      photo: data['photo'],
      name: data['name'],
      price: data['price'],
      description: data['description'],
      categories: List<String>.from(data['categories']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'barcode': barcode,
      'photo': photo,
      'name': name,
      'price': price,
      'description': description,
      'categories': categories,
    };
  }
}
//product