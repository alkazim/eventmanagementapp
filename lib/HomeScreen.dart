import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventmanagementapp/My DesignsBday.dart';
import 'package:eventmanagementapp/MyDesigns.dart';
import 'package:eventmanagementapp/ProfileScreen.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int bottomnavi_index = 0;

  final List<Widget> screens = [
    Homescreens(),
    MyDesigns(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[bottomnavi_index],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          Icons.home_filled,
          Icons.palette_rounded,
          Icons.person_2_rounded,
        ],
        backgroundColor: Color(0xFFfbf9fe),//BNB color
        activeIndex: bottomnavi_index,
        notchMargin: 3,
        splashColor: Colors.purple,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        activeColor: Color(0xFF01513a),
        inactiveColor: Colors.green.shade100,
        onTap: (index) => setState(() => bottomnavi_index = index),
        height: 50,
        // backgroundColor: Color(0xFF4683B5),
      ),
    );
  }
}

class Homescreens extends StatelessWidget {
  Homescreens({super.key});

  List<String> ImageList = [
    'lib/assets/bday party.jpg',
    'lib/assets/wedding_ceremony.jpg',
    'lib/assets/Corporate_Event.jpg',
    'lib/assets/graduation event.jpg',
    'lib/assets/Shop inaugartion.jpg'
  ];
  final List<String> eventNames = [
    'Birthday Party',
    'Wedding Ceremony',
    'Business Seminar',
    'Graduation Party',
    'Shop Inaugration'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(
            child: Text(
              "Home",
              style: TextStyle(fontSize: 28,color: Color(0xFF3d466b),fontFamily: 'Cinzel',fontWeight: FontWeight.w800),
            ),
          ),
        ),
        backgroundColor: Color(0xFFf0ecff),// appBar color
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFFf0ecff),//body color
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 8.0),
                //   child: Text(
                //     "Events  ",
                //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'BabasNeue'),
                //   ),
                //),
                Container(
                 // height: 250,
                  height: MediaQuery.of(context).size.height/2.95,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventNames.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          //image container
                          //height: 100,
                          width: 300,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      eventNames[index],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF01513a)),// create button color
                                        onPressed: () {
                                          if (eventNames[index] ==
                                              'Birthday Party')
                                            Navigator.pushNamed(
                                                context, 'Bday Template');
                                          else if (eventNames[index] ==
                                              'Wedding Ceremony')
                                            Navigator.pushNamed(
                                                context, 'Wedding Template');
                                          else if (eventNames[index] ==
                                              'Business Seminar')
                                            Navigator.pushNamed(
                                                context, 'Seminar Template');
                                          else if (eventNames[index] ==
                                              'Graduation Party')
                                            Navigator.pushNamed(
                                                context, 'Graduation Template');
                                        },
                                        child: Text("Create",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                  ))
                            ],
                          ),
                          decoration: BoxDecoration(
                            //color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(ImageList[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text("Past Events",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600,color: Color(0xFF3d466b),fontFamily: 'Cinzel')),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                   // height: MediaQuery.of(context).size.height/2.3,
                    child: ListView(
                     // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        CarouselSlider(
                          items: [
                            Container(
                             // height: 350,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/Images/Past Events/Birthday Card.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                             // height: 350,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/Images/Past Events/Business Seminar.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                             // height: 350,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/Images/Past Events/Graduation Day.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              //height: 350,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/Images/Past Events/Wedding Ceremony.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: MediaQuery.of(context).size.height/2.3,
                            aspectRatio: 4/5,
                            viewportFraction: 0.53,
                            //autoPlay: true
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
