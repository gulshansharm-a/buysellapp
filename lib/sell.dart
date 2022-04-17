import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SellView extends StatefulWidget {
  final String token;
  SellView(this.token);
  @override
  _SellViewState createState() => _SellViewState();
}

class _SellViewState extends State<SellView> {
  bool isLoading;

  TextEditingController _title;
  TextEditingController _description;
  TextEditingController _price;
  String _type;
  String _imagePath;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    _title = TextEditingController();
    _description = TextEditingController();
    _price = TextEditingController();
    _type = 'Cars';
    _imagePath = null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Sell',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                'Products',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Title',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 0, 16, 0),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: _title,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 16),
                          border: InputBorder.none,
                          hintText: 'Enter title',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 0, 16, 0),
                      height: 75,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        maxLines: 3,
                        controller: _description,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 16),
                          border: InputBorder.none,
                          hintText: 'Enter description',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Price',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 0, 16, 0),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _price,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 16),
                          border: InputBorder.none,
                          hintText: 'Enter price',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(
                        'Image',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        onPressed: () async {
                          PickedFile _file = await ImagePicker().getImage(
                            source: ImageSource.gallery,
                          );
                          setState(() {
                            _imagePath = _file.path;
                          });
                        },
                        child: Text(
                          _imagePath == null
                              ? 'Select Image'
                              : _imagePath.split('/').last,
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Type',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: DropdownButton(
                            value: _type,
                            items: [
                              DropdownMenuItem(
                                child: Text('Cars'),
                                value: 'Cars',
                              ),
                              DropdownMenuItem(
                                child: Text('Sports'),
                                value: 'Sports',
                              ),
                              DropdownMenuItem(
                                child: Text('Pets'),
                                value: 'Pets',
                              ),
                              DropdownMenuItem(
                                child: Text('Fashion'),
                                value: 'Fashion',
                              ),
                              DropdownMenuItem(
                                child: Text('Books'),
                                value: 'Books',
                              ),
                              DropdownMenuItem(
                                child: Text('Furniture'),
                                value: 'Furniture',
                              ),
                              DropdownMenuItem(
                                child: Text('Appliances'),
                                value: 'Appliances',
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _type = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          if (_imagePath == null) {
                            Fluttertoast.showToast(msg: 'Select Image!!!');
                            return;
                          }
                          if (_description.text == null ||
                              _price.text == null ||
                              _title.text == null) {
                            Fluttertoast.showToast(
                                msg: 'Fill all the details!!!');
                            return;
                          }
                          var response = await uploadProduct(
                            widget.token,
                            _title.text,
                            _description.text,
                            _price.text,
                            _type,
                            _imagePath,
                          );
                          if (response) {
                            setState(() {
                              _title.clear();
                              _description.clear();
                              _price.clear();
                              _imagePath = '';
                              _type = 'Cars';
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: isLoading
                              ? SpinKitRipple(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Sell',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future uploadProduct(String token, String title, String description,
      String price, String type, String imagePath) async {
    setState(() {
      isLoading = true;
    });
    String uri = 'https://buy-and-sell-online.herokuapp.com/user/product/';

    var request = new http.MultipartRequest(
      "POST",
      Uri.parse(uri),
    );
    request.headers['Authorization'] = 'Token $token';

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['type'] = type;
    request.fields['price_offered'] = price;

    request.files.add(
      new http.MultipartFile(
          'image',
          File.fromUri(Uri.parse(imagePath)).readAsBytes().asStream(),
          File(imagePath).lengthSync(),
          filename: imagePath.split('/').last),
    );
    var response = await request.send();
    print(response.statusCode);
    print(response.stream.bytesToString());
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
