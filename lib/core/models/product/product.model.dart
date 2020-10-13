class Product {
  String id;
  String createdAt;
  String updateAt;
  String name;
  String description;
  int price;
  int quantity;
  String dimension;

  Product({
    this.id,
    this.createdAt,
    this.updateAt,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.dimension,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      createdAt: json['createdAt'],
      updateAt: json['updateAt'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      dimension: json['dimension'],
    );
  }

  Map<String, dynamic> toJson(Product product) {
    return {
      'createdAt': this.createdAt,
      'updateAt': this.updateAt,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'quantity': this.quantity,
      'dimension': this.dimension,
    };
  }
}
