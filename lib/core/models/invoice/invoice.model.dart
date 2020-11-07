import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/core/models/invoice/installment.model.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/models/user/user.model.dart';

class Invoice extends Model<String> {
  String id;
  int total;
  int discount;
  List<Installment> installments;
  List<User> sellers;
  List<User> buyers;
  List<Product> products;

  Invoice({
    this.id,
    this.total,
    this.discount,
    this.installments,
    this.sellers,
    this.buyers,
    this.products,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      total: json['total'],
      discount: json['discount'],
      installments: json['installments'] != null
          ? json['installments']
              .map<Installment>(
                  (installment) => Installment.fromJson(installment))
              .toList()
          : null,
      sellers: json['sellers'] != null
          ? json['sellers']
              .map<User>((seller) => User.fromJson(seller))
              .toList()
          : null,
      buyers: json['buyers'] != null
          ? json['buyers'].map<User>((buyer) => User.fromJson(buyer)).toList()
          : null,
      products: json['products'] != null
          ? json['products']
              .map<Product>((product) => Product.fromJson(product))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': this.total,
      'discount': this.discount,
      'installments': this.installments != null
          ? this
              .installments
              .map((installment) => installment.toJson())
              .toList()
          : null,
      'sellers': this.sellers != null
          ? this.sellers.map((seller) => seller.toJson()).toList()
          : null,
      'buyers': this.buyers != null
          ? this.buyers.map((buyer) => buyer.toJson()).toList()
          : null,
      'products': this.products != null
          ? this.products.map((product) => product.toJson()).toList()
          : null,
    };
  }
}

class CreateInvoice extends Model<String> {
  int discount;
  List<Installment> installments;
  List<String> products;

  CreateInvoice({
    this.discount,
    this.products,
    this.installments,
  });

  Map<String, dynamic> toJson() {
    return {
      'discount': this.discount,
      'installments': this.installments != null
          ? this
              .installments
              .map((installment) => installment.toJson())
              .toList()
          : null,
      'products': this.products,
    };
  }
}
