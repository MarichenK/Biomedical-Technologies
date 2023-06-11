import 'package:flutter/material.dart';

final List _stores = [
    'Eurospar',
    'Conad',
    'Pam',
    'Iper Rosetto',
    'Ali',
    'Lidl',
    'Eurospin'
  ];

class MapPage extends StatelessWidget {
  static const route = '/map/';
  static const routename = 'Map';

  @override
  Widget build(BuildContext context) {
    print('${MapPage.routename} built');
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: AppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0,
            ),
          ),
          body: Column(
            children: [
              Container(
                height: 450,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/map_image.jpg'),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 17),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Stores near you',
                    textScaleFactor: 1.5,
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 20,
                    crossAxisCount: 2,
                    
                    children: List.generate(_stores.length, (index) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 140,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 237, 237, 237),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: Text(_stores[index]),
                            ),
                          ),
                        ],
                      ));
                    })),
              )
            ],
          )),
    );
  } //build
} //ProfilePage