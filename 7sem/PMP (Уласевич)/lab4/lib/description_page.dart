import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lab4/product.dart';

class DescriptionPage extends StatefulWidget {
  final Product product;

  DescriptionPage({required this.product});

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  late Product product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product = widget.product;
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 0.9),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            InkWell(
                onTap: () {
                  print("tap");
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.favorite_outline,
                    size: 30,
                  ),
                ))
          ],
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_backspace,
              size: 30,
            ),
          )),
      body: Column(
        children: <Widget>[
          SizedBox(
              child: Row(
            children: <Widget>[
              SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          product.firstColor,
                          width: 30,
                          height: 30,
                        ),
                        Image.asset(
                          product.secondColor,
                          width: 30,
                          height: 30,
                        ),
                        Image.asset(
                          product.thirdColor,
                          width: 30,
                          height: 30,
                        ),
                        Image.asset(
                          product.fourthColor,
                          width: 30,
                          height: 30,
                        )
                      ],
                    ),
                  )),
              Expanded(
                  child: SizedBox(
                width: 150,
                height: 350,
                child: Image.asset(product.image),
              )),
              SizedBox(
                width: 50,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    "assets/icons/360.png",
                    width: 40,
                    height: 40,
                  ),
                ),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 14 / 2,
                      backgroundColor: Colors.white,
                    ),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                    ),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: SizedBox(
            width: 400,
            child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ),
                            SizedBox(
                              width: 165,
                              child: Text(
                                product.company,
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromRGBO(180, 180, 180, 1),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 2.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 3,
                              itemSize: 20,
                              ignoreGestures: true,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                              onRatingUpdate: (rating) {},
                            )
                          ]),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            product.cost,
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 10, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.water_drop_outlined,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "3 ML",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.battery_charging_full_sharp,
                                    color: Colors.grey,
                                  ),
                                  Text("1100 MAH",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.scale_outlined,
                                    color: Colors.grey,
                                  ),
                                  Text("80 G",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Stack(
                          children: <Widget>[
                            const Text(
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                              "Compact and attractive, the North pod kit by Smoktech is an electronic cigarette with interesting potential for light vaping everywhere, whether direct or indirect. Nord is a newly-designed button-triggered pod system device."
                              " It has 1100mAh battery capacity, extremely large among podsystem devices, making it a definitely powerful one! It is equipped with two exclusive coils",
                              style: TextStyle(fontSize: 15),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.white.withOpacity(0.5),
                                      Colors.white,
                                    ],
                                    stops: const [0.1, 0.1, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                              width: 110,
                              height: 45,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 12,
                                            offset: const Offset(0, 2))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            if (count > 0) {
                                              setState(() {
                                                count--;
                                              });
                                            }
                                          },
                                          child: const Text(
                                            "–",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, left: 15),
                                          child: Text(
                                            "$count",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                count++;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              size: 17,
                                            ))
                                      ],
                                    ),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(left: 70),
                            child: InkWell(
                              onTap: (){
                                print("added");
                              },
                              child: SizedBox(
                                width: 160,
                                height: 45,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 12,
                                            offset: const Offset(0, 2))
                                      ]),
                                  child: const Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 25),
                                        child: SizedBox(
                                          width: 90,
                                          child: Text(
                                            "Add to cart",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ))
        ],
      ),
    );
  }
}
