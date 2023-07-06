// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// The different stores and link to Google Maps
final List _stores = [
  ['Eurospar', 'https://www.google.com/maps/search/EUROSPAR/'],
  ['Conad', 'https://www.google.com/maps/search/Conad/'],
  ['Pam', 'https://www.google.com/maps/search/pam+local/'],
  ['Iper Rosetto', 'https://www.google.com/maps/search/iper+rosetto/'],
  ['Ali', 'https://www.google.com/maps/search/Al%C3%AC+Supermercato/'],
  ['Lidl', 'https://www.google.com/maps/search/lidl/'],
  ['Eurospin', 'https://www.google.com/maps/search/Eurospin/']
];

// The different stores and logo assets
// Got index range issues when the lists where together, so they are split
final List _storesLogo = [
  ['Eurospar', 'assets/logos/spar.jpeg'],
  ['Conad', 'assets/logos/conad.png'],
  ['Pam', 'assets/logos/pam.png'],
  ['Iper Rosetto', 'assets/logos/iperrosetto.png'],
  ['Ali', 'assets/logos/ali.png'],
  ['Lidl', 'assets/logos/lidl.png'],
  ['Eurospin', 'assets/logos/eurospin.png']
];


class MapPage extends StatelessWidget {
  static const route = '/map/';
  static const routename = 'Map';

  // Function to launch url, here: Google Maps
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
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Scaffold(

        // Hide appbar
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
          ),
        ),

        body: Column(
          children: [

            // Map
            // InkWell makes it possible to add a hyperlink to an object
            InkWell(onTap: () {_launchURL("https://www.google.com/maps/place/Dipartimento+di+Ingegneria+dell'Informazione+(DEI)/@45.4088728,11.8935797,17.8z/data=!4m6!3m5!1s0x477edb664644067d:0xb57b9fafc118efea!8m2!3d45.4090531!4d11.894346!16s%2Fg%2F11smqr8g50?entry=ttu");},
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

            // Start of listview
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Stores near you',
                    textScaleFactor: 2.2,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),

            // Listview
            // Buttons with shops in the listview
            Expanded(
              child: GridView.count(
                  childAspectRatio: 1.5,  // Space between buttons
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,      // Two buttons each row
                  children: List.generate(_stores.length, (index) {
                    return Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [SizedBox(
                        height: 112,
                        child: ElevatedButton(  // Buttons are created using ElevatedButton
                          style: ButtonStyle(
                              elevation: const MaterialStatePropertyAll(0),
                              backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 237, 237, 237)),
                              foregroundColor: const MaterialStatePropertyAll(Colors.black),
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                          onPressed: () {_launchURL(_stores[index][1]);},
                          
                          // Adding shop logos and text to the buttons
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                                      image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(_storesLogo[index][1]),
                                    )),
                              ),
                                Text(_stores[index][0]),
                              ],
                            ),
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
  } 
}