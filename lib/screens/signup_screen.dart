import 'package:flutter/material.dart';

import '../widgets/efficacyLogo.dart';

//added signup buttons

class SignupPage extends StatefulWidget {
  static const routeName = '/signup-screen';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            //defining background of signup screen
            Container(
              height: deviceSize.height,
              width: deviceSize.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    Color.fromRGBO(53, 114, 164, 1),
                    Color.fromRGBO(37, 57, 118, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  stops: const [0, 1],
                ),
              ),
            ),
            //background will contain the logo
            EfficacyLogo(deviceSize: deviceSize),
          ],
        ),
      ),
    );
  }
}
