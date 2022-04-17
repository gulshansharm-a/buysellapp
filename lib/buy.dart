import 'dart:ui';
import 'package:buy_and_sell/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BuyView extends StatefulWidget {
  final String token;
  BuyView(this.token);
  @override
  _BuyViewState createState() => _BuyViewState();
}

class _BuyViewState extends State<BuyView> {
  List<ProductList> productList;
  @override
  void initState() {
    super.initState();
    productList = List();
    getProducts(widget.token).then((value) {
      setState(() {
        productList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Buy',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Products',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              margin: const EdgeInsets.all(16.0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Icon(
                Icons.filter_list,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(15, 15, 15, 0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Products',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black54,
                )),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => buildProductCard(index),
            itemCount: productList.length,
          ),
        )
      ],
    );
  }

  Column buildProductCard(int index) {
    return Column(
      children: [
        Container(
          height: 250,
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Image.network(
            productList[index].image,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          height: 75,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productList[index].title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '₹ ' + productList[index].priceOffered.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future getProducts(String token) async {
    var header = {"Authorization": "Token $token"};
    http.Client client = new http.Client();
    String uri = 'https://buy-and-sell-online.herokuapp.com/product/all/';
    var response = await client.get(uri, headers: header);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200)
      return productListFromJson(response.body);
    else
      return List();
  }
}
