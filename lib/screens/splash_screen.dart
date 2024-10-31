import 'package:ecommerce_demo/screens/product_main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetomainscreen();
  }
  void _navigatetomainscreen()async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ProductMainScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: RichText(text: TextSpan(
          children: [
            TextSpan(
              text: 'Pro', // This part will be styled separately
              style: TextStyle(
                color: Colors.blue, // Color for 'Pro'
                fontSize: 36, // Font size for 'Pro'
                fontWeight: FontWeight.bold, // Font weight for 'Pro'
              ),
            ),
            TextSpan(
              text: ' Shopping', // This part will use the default text style
              style: TextStyle(
                color: Colors.black, // Color for the rest of the title
                fontSize: 30, // Font size for the rest of the title
              ),
            ),
          ],
        )),
      ),

    );
  }
}
