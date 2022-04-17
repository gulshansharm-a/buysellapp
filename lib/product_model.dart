import 'dart:convert';

List<ProductList> productListFromJson(String str) => List<ProductList>.from(
    json.decode(str).map((x) => ProductList.fromJson(x)));

String productListToJson(List<ProductList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductList {
  ProductList({
    this.id,
    this.type,
    this.buyer,
    this.seller,
    this.title,
    this.description,
    this.image,
    this.postDate,
    this.isSold,
    this.priceOffered,
  });

  int id;
  String type;
  dynamic buyer;
  Seller seller;
  String title;
  String description;
  String image;
  DateTime postDate;
  bool isSold;
  int priceOffered;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        id: json["id"],
        type: json["type"],
        buyer: json["buyer"],
        seller: Seller.fromJson(json["seller"]),
        title: json["title"],
        description: json["description"],
        image: json["image"],
        postDate: DateTime.parse(json["post_date"]),
        isSold: json["is_sold"],
        priceOffered: json["price_offered"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "buyer": buyer,
        "seller": seller.toJson(),
        "title": title,
        "description": description,
        "image": image,
        "post_date": postDate.toIso8601String(),
        "is_sold": isSold,
        "price_offered": priceOffered,
      };
}

class Seller {
  Seller({
    this.username,
    this.phoneNo,
  });

  String username;
  String phoneNo;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        username: json["username"],
        phoneNo: json["phone_no"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "phone_no": phoneNo,
      };
}
