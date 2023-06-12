import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final List _stores = [
    ['Eurospar', 'https://www.google.com/maps/search/EUROSPAR/'],
    ['Conad', 'https://www.google.com/maps/search/Conad/'],
    ['Pam', 'https://www.google.com/maps/search/pam+local/'],
    ['Iper Rosetto', 'https://www.google.com/maps/search/iper+rosetto/'],
    ['Ali', 'https://www.google.com/maps/search/Al%C3%AC+Supermercato/'],
    ['Lidl', 'https://www.google.com/maps/search/lidl/'],
    ['Eurospin', 'https://www.google.com/maps/search/Eurospin/']
  ];

class MapPage extends StatelessWidget {
  static const route = '/map/';
  static const routename = 'Map';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Cannot launch url';
    }
  }

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
              InkWell(
                onTap: () {_launchURL("https://www.google.com/maps/place/Dipartimento+di+Ingegneria+dell'Informazione+(DEI)/@45.4088728,11.8935797,17.8z/data=!4m6!3m5!1s0x477edb664644067d:0xb57b9fafc118efea!8m2!3d45.4090531!4d11.894346!16s%2Fg%2F11smqr8g50?entry=ttu");},
                child: Container(
                  height: 450,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/map_image.jpg'),
                      )),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 17),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Stores near you',
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
              ),

              Expanded(
                child: GridView.count(
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 20,
                    crossAxisCount: 2,
                    
                    children: List.generate(_stores.length, (index) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 120,
                            child: ElevatedButton(
                              
                              style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(0),
                                backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 237, 237, 237)),
                                foregroundColor: const MaterialStatePropertyAll(Colors.black),
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))) 
                              ),
                              onPressed: () {_launchURL(_stores[index][1]);},

                              child: Center(
                                child: Text(_stores[index][0]),
                              ),
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