import 'package:invictus/core/models/base.model.dart';
import 'package:invictus/core/models/invoice/invoice.model.dart';

class Installment extends Model<String> {
  String id;
  String paymentMethod;
  int price;
  String title;
  DateTime paymentDate;
  String paymentStatus;
  Invoice invoice;
  DateTime expirationDate;

  Installment({
    this.id,
    this.paymentMethod,
    this.price,
    this.title,
    this.paymentDate,
    this.paymentStatus,
    this.invoice,
    this.expirationDate,
  });

  factory Installment.fromJson(Map<String, dynamic> json) {
    DateTime paymentDate;
    DateTime expirationDate;

    if (json['paymentDate'] != null) {
      paymentDate = DateTime.parse(json['paymentDate']);
    }

    if (json['expirationDate'] != null) {
      expirationDate = DateTime.parse(json['expirationDate']);
    }

    return Installment(
      id: json['id'],
      paymentMethod: json['paymentMethod'],
      price: json['price'],
      title: json['title'],
      paymentDate: paymentDate,
      paymentStatus: json['paymentStatus'],
      invoice: json['invoice'] != null
          ? Invoice.fromJson(
              json['invoice'],
            )
          : null,
      expirationDate: expirationDate,
    );
  }

  Map<String, dynamic> toJson() {
    String paymentDate;
    String expirationDate;

    if (this.paymentDate != null) {
      paymentDate = this.paymentDate.toIso8601String();
    }

    if (this.expirationDate != null) {
      expirationDate = this.expirationDate.toIso8601String();
    }

    return {
      'paymentMethod': this.paymentMethod,
      'price': this.price,
      'title': this.title,
      'paymentDate': paymentDate,
      'paymentStatus': this.paymentStatus,
      'invoice': this.invoice != null ? this.invoice.toJson() : null,
      'expirationDate': expirationDate,
    };
  }
}
