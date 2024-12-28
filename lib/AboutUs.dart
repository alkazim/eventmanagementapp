import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFf0ecff),
          title: Center(
            child: Text(
              "About Us",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Cinzel',
                  fontWeight: FontWeight.bold),
            ),
          ),
          //automaticallyImplyLeading: false,
        ),
        backgroundColor: Color(0xFFf0ecff),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      // This creates a circular shape
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              150), // Match border radius with ClipRRect// Circular border color and width
                        ),
                        child: Image.asset(
                          'lib/assets/Images/introScreen/plan for every occasion.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Welcome to Eventify, the ultimate app for creating and customizing stunning event designs. "
                    "Whether you're planning a wedding, birthday, business seminar, or any special occasion, "
                    "Eventify offers a variety of predefined templates that you can easily personalize. With "
                    "just a few taps, you can customize designs to match your theme and style. Once you're happy "
                    "with your creation, download it directly to your gallery for easy access, sharing, or printing. "
                    "Eventify makes event planning simple, creative, and hassle-free, helping you bring your vision to "
                    "life effortlessly.",
                    style: TextStyle(fontFamily: 'TimesNewRoman', fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(
                          'lib/assets/Images/introScreen/welcome to the app.jpg')),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Eventify",
                    style: TextStyle(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text("Address : Palarivattom , Ernakulam, Kerala",
                      style: TextStyle(fontFamily: 'TimesNewRoman')),
                  Text("Contact : muhammedalkazim@gmail.com",
                      style: TextStyle(fontFamily: 'TimesNewRoman')),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://cdn-icons-png.freepik.com/256/15707/15707869.png?semt=ais_hybrid',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://1000logos.net/wp-content/uploads/2017/02/Facebook-Logosu.png',
                        ),
                        radius: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY9nMxXB8vKkqx9z5JRqWW7WbdKoqhpt1EhQ&s',
                        ),
                        radius: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
