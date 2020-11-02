import 'package:flutter/material.dart';

import './dropdown_menu.dart';
import './nextButton.dart';
import './signupButton.dart';

class SignupCard extends StatefulWidget {
  Size deviceSize;

  SignupCard({
    @required this.deviceSize,
  });

  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _adminCredentials = {
    'name': '',
    'email': '',
    'password': '',
    'club': '',
    'branch': '',
  };
  bool _isLoading = false;
  bool _isNextClicked = false;
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Color.fromRGBO(37, 57, 118, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 8.0,
      child: Container(
        height: widget.deviceSize.height * 0.58,
        width: widget.deviceSize.width * 0.85,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: !_isNextClicked
                    ? SignupPart1(
                        adminCredentials: _adminCredentials,
                        passwordController: _passwordController,
                      )
                    : DropdownMenu(deviceSize: widget.deviceSize,),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            !_isNextClicked
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _isNextClicked = true;
                      });
                    },
                    child: NextButton(),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(4.0),
                        alignment: Alignment.centerLeft,
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 45,
                          color: Theme.of(context).buttonColor,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _isNextClicked = false;
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {},
                            child: SignupButton(),
                          ),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

///**************************First part of signup page***********************///

class SignupPart1 extends StatelessWidget {
  const SignupPart1({
    Key key,
    @required Map<String, String> adminCredentials,
    @required TextEditingController passwordController,
  })  : _adminCredentials = adminCredentials,
        _passwordController = passwordController,
        super(key: key);

  final Map<String, String> _adminCredentials;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
/******************Name Field****************************/
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: Theme.of(context).textTheme.subtitle1,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value.isEmpty) {
              return 'This Field cant be empty';
            }
            return '';
          },
          style: Theme.of(context).textTheme.headline6,
          onSaved: (String value) => _adminCredentials['name'] = value,
        ),
/***************Email Field*******************/
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email Id',
            labelStyle: Theme.of(context).textTheme.subtitle1,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value.isEmpty ||
                !value.contains('@') ||
                !value.endsWith('@gmail.com') ||
                !value.endsWith('@yahoo.com')) {
              return 'Invalid Email';
            }
            return '';
          },
          style: Theme.of(context).textTheme.headline6,
          onSaved: (String value) => _adminCredentials['email'] = value,
        ),
/****************Password Field*****************/
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: Theme.of(context).textTheme.subtitle1,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'This field can\'t be empty';
            }
            if (value.length < 6) {
              return 'Password should be atleast 6 characters long';
            }
            return '';
          },
          style: Theme.of(context).textTheme.headline6,
          obscureText: true,
          obscuringCharacter: '*',
          onSaved: (value) => _adminCredentials['password'] = value,
        ),
        /************* Confirm Password ************/
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: Theme.of(context).textTheme.subtitle1,
          ),
          validator: (value) {
            if (value != _passwordController) {
              return 'Passwords do not match';
            }
            return '';
          },
          style: Theme.of(context).textTheme.headline6,
          obscureText: true,
          obscuringCharacter: '*',
        ),
      ],
    );
  }
}
