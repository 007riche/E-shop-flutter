import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/consts/colors.dart';
import 'package:eshop/services/global_alert_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/upload_product_orm';

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();

  var _productTitle = '';
  var _productPrice = '';
  var _productCategory = '';
  var _productBrand = '';
  var _productDescription = '';
  var _productQuantity = '';
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  String _categoryValue = 'Select a Category';
  String _brandValue = 'Select a brand';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalAlertMethod _globalAlertMethod = GlobalAlertMethod();
  bool _isSending = false;
  String _productImageUrl = "";
  var uuid = Uuid();

  var _pickedImage;
  showAlertDialog(BuildContext context, String title, String body) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    // if (isValid) {
    //   _formKey.currentState!.save();
    //   print(_productTitle);
    //   print(_productPrice);
    //   print(_productCategory);
    //   print(_productBrand);
    //   print(_productDescription);
    //   print(_productQuantity);
    //   // Use those values to send our auth request ...
    // }

    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_pickedImage == null) {
          _globalAlertMethod.authErrorHandlingDialog(
              context: context, subTitle: "Please choose an image");
        } else {
          setState(() {
            _isSending = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child("productsImages")
              .child(_productTitle.toString().replaceAll(" ", "_") + ".png");
          await ref.putFile(_pickedImage);
          _productImageUrl = await ref.getDownloadURL();

          final User? currentUser = _auth.currentUser;
          final _uid = currentUser!.uid;
          final productId = uuid.v4();
          await FirebaseFirestore.instance
              .collection("products")
              .doc(productId)
              .set({
            "productId": productId,
            "userId": _uid,
            "productName": _productTitle,
            "price": _productPrice,
            "productCategory": _productCategory,
            "productImageUrl": _productImageUrl,
            "productBrand": _productBrand,
            "productDescription": _productDescription,
            "productQuantity": _productQuantity,
            "accountCreationdate": Timestamp.now(),
          });
          Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;
        }
      } catch (error) {
        _globalAlertMethod.authErrorHandlingDialog(
            context: context, subTitle: error.toString());
        print(error);
      } finally {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile!;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = "One";
    return SafeArea(
      child: Scaffold(
        bottomSheet: Container(
          height: kBottomNavigationBarHeight * 0.8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsConsts.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: Material(
            color: Theme.of(context).backgroundColor,
            child: InkWell(
              onTap: _trySubmit,
              splashColor: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: _isSending
                        ? Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text('Upload',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center),
                  ),
                  if (!_isSending)
                    GradientIcon(
                      Feather.upload,
                      20,
                      LinearGradient(
                        colors: <Color>[
                          Colors.green,
                          Colors.yellow,
                          Colors.deepOrange,
                          Colors.orange,
                          Colors.yellow.shade800,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Card(
                  margin: EdgeInsets.all(15),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 9),
                                  child: TextFormField(
                                    key: ValueKey('Title'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a Title';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Product Title',
                                    ),
                                    onSaved: (value) {
                                      _productTitle = value!;
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  key: ValueKey('Price ₹'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Price is missed';
                                    }
                                    return null;
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Price ₹',
                                    //  prefixIcon: Icon(Icons.mail),
                                    // suffixIcon: Text(
                                    //   '\n \n \$',
                                    //   textAlign: TextAlign.start,
                                    // ),
                                  ),
                                  //obscureText: true,
                                  onSaved: (value) {
                                    _productPrice = value!;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          /* Image picker here ***********************************/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                //  flex: 2,
                                child: this._pickedImage == null
                                    ? Container(
                                        margin: EdgeInsets.all(10),
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.all(10),
                                        height: 200,
                                        width: 200,
                                        child: Container(
                                          height: 200,
                                          // width: 200,
                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.only(
                                            //   topLeft: const Radius.circular(40.0),
                                            // ),
                                            color: Theme.of(context)
                                                .backgroundColor,
                                          ),
                                          child: Image.file(
                                            this._pickedImage,
                                            fit: BoxFit.contain,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    child: FlatButton.icon(
                                      textColor: Colors.white,
                                      onPressed: _pickImageCamera,
                                      icon: Icon(Icons.camera,
                                          color: Theme.of(context).accentColor),
                                      label: Text(
                                        'Camera',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .textSelectionColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: FlatButton.icon(
                                      textColor: Colors.white,
                                      onPressed: _pickImageGallery,
                                      icon: Icon(Icons.image,
                                          color: Theme.of(context).accentColor),
                                      label: Text(
                                        'Gallery',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .textSelectionColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: FlatButton.icon(
                                      textColor: Colors.white,
                                      onPressed: _removeImage,
                                      icon: Icon(
                                        Icons.remove_circle_rounded,
                                        color: Colors.red,
                                      ),
                                      label: Text(
                                        'Remove',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                // flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 9),
                                  child: Container(
                                    child: TextFormField(
                                      controller: _categoryController,

                                      key: ValueKey('Category'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a Category';
                                        }
                                        return null;
                                      },
                                      //keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Add a new Category',
                                      ),
                                      onSaved: (value) {
                                        _productCategory = value!;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              DropdownButton<String>(
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).textSelectionColor),
                                underline: Container(
                                  height: 2,
                                  color: Colors.amber.shade900,
                                ),
                                value: _categoryValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    _categoryValue = value!;
                                    _categoryController.text = value;
                                    // _controller.text= _productCategory;
                                    print(_productCategory);
                                  });
                                },
                                items: <String>[
                                  'Select a Category',
                                  'Appliances',
                                  'Electronics',
                                  'Fashion',
                                  'Fitness & Sport',
                                  'Footwears',
                                  'Furnitures',
                                  'Beauty & Cosmetics',
                                  'Foods & Healthcare',
                                  'Kitchen',
                                  'Phones',
                                  'Watches',
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 9),
                                  child: Container(
                                    child: TextFormField(
                                      controller: _brandController,

                                      key: ValueKey('Brand'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Brand is missed';
                                        }
                                        return null;
                                      },
                                      //keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Brand',
                                      ),
                                      onSaved: (value) {
                                        _productBrand = value!;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              DropdownButton<String>(
                                value: _brandValue,
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).textSelectionColor),
                                underline: Container(
                                  height: 2,
                                  color: Colors.amber.shade900,
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    _brandValue = value!;
                                    _brandController.text = value;
                                    print(_productBrand);
                                  });
                                },
                                items: <String>[
                                  'Select a brand',
                                  'No brand',
                                  'Acer',
                                  'Apple',
                                  'Dell',
                                  'H&M',
                                  'HP',
                                  'Huawei',
                                  'Nike',
                                  'Oppo',
                                  'Samsung',
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                              //     DropdownButton<String>(
                              //       items: [
                              //         DropdownMenuItem<String>(
                              //           child: Text('Brandless'),
                              //           value: 'Brandless',
                              //         ),
                              //         DropdownMenuItem<String>(
                              //           child: Text('Addidas'),
                              //           value: 'Addidas',
                              //         ),
                              //         DropdownMenuItem<String>(
                              //           child: Text('Apple'),
                              //           value: 'Apple',
                              //         ),
                              //         DropdownMenuItem<String>(
                              //           child: Text('Dell'),
                              //           value: 'Dell',
                              //         ),
                              //         DropdownMenuItem<String>(
                              //           child: Text('H&M'),
                              //           value: 'H&M',
                              //         ),
                              //         DropdownMenuItem<String>(
                              //           child: Text('Nike'),
                              //           value: 'Nike',
                              //         ),
                              //         DropdownMenuItem<String>(
                              //           child: Text('Samsung'),
                              //           value: 'Samsung',
                              //         ),
                              //         DropdownMenuItem<String>(
                              //           child: Text('Huawei'),
                              //           value: 'Huawei',
                              //         ),
                              //       ],
                              // onChanged: (String? value) {
                              //   setState(() {
                              //     _brandValue = value!;
                              //     _brandController.text = value;
                              //     print(_productBrand);
                              //   });
                              // },
                              //       hint: Text('Select a Brand'),
                              //       value: _brandValue,
                              //     ),
                            ],
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                              key: ValueKey('Description'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'product description is required';
                                }
                                return null;
                              },
                              //controller: this._controller,
                              maxLines: 10,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                //  counterText: charLength.toString(),
                                labelText: 'Description',
                                hintText: 'Product description',
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                _productDescription = value!;
                              },
                              onChanged: (text) {
                                // setState(() => charLength -= text.length);
                              }),
                          //    SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                //flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 9),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    key: ValueKey('Quantity'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Quantity is missed';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Quantity',
                                    ),
                                    onSaved: (value) {
                                      _productQuantity = value!;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
