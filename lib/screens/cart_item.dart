// cart_item
class CartItem {
  String barcode;
  String photo;
  String name;
  double price;
  int quantity;

  CartItem({
    required this.barcode,
    required this.photo,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}
