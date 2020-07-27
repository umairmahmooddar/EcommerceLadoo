import 'package:flutter/cupertino.dart';
import 'package:superssecommerce/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:superssecommerce/components/rounded_input_field.dart';
import 'package:superssecommerce/screens/main/main_page.dart';

import 'forgot_password_page.dart';
import 'register_page.dart';

class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  TextEditingController uname = TextEditingController();

  TextEditingController password = TextEditingController();

  bool isPasswordAuthentic(String password )
  {
    int Length = 8;
    if(password.isEmpty)
      {
        return false;
      }
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));

    bool hasMinLength = password.length > Length;

    return hasDigits & hasUppercase & hasLowercase & hasMinLength;
  }


  bool username_Enable = false;
  bool pass_Enable = false;
  bool is_number = false;
  bool is_username = false;
  bool password_identifier;

  bool button_Enable = false;

  Widget _buildUsername()
  {
    return TextField(
      decoration: InputDecoration(labelText: 'UserNme / PhoneNumber',
      icon: Icon(Icons.person)
      ),
      controller: uname,
      onChanged: (String value)
      {
        setState(() {


        if( (RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value) ) && value.length > 10)
          {
            
            is_username = true;
          }else
              {
                is_username = false;
              }
        if(RegExp(r"/^[0-9]{11}$/").hasMatch(value))
        {
          is_number = true;
        }else
          {
            is_number = false;
          }

        if(is_number == true || is_username == true)
          {
              username_Enable = true;
          }else
            {
              username_Enable = false;
            }
        });
      },


//      validator: (String value) {
//        if (value.isEmpty) return 'UserName is required';
//
//
//        return null;
//      },
//      onSaved: (String value) {
//        _uname = value;
//      },
    );

  }
  Widget _buildPassword()
  {
    return TextField(

      enabled: username_Enable ? true : false,
      obscureText: true,
      controller: password,
      decoration: InputDecoration(labelText: 'Password',
      icon: Icon(Icons.lock),
      errorText:'Enter Valid Password',
      ),

      onTap: (){
        print(username_Enable);
      },

      onChanged: (String value)
      {

        setState(() {


        password_identifier = isPasswordAuthentic(value);
        if(password_identifier == true)
          {
            pass_Enable = true;
            if(pass_Enable == true && username_Enable ==true)
              {
                button_Enable = true;
              }else
                {
                  button_Enable = false;
                }
          }
        });

        return null;
      },




    );

  }
  var _formKey = GlobalKey<FormState>();
  var _onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget welcomeBack = Text(
      'Welcome Back',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(
          left: 0,
        ),
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 50),
          child: Text(
            'Login to your account using\nMobile number',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ));

    Widget loginButton = Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(

        onTap: button_Enable ? () {

          setState(() {
            if (uname.text == "12345678901") {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RegisterPage()));
            }else
            {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => MainPage()));
            }
          });


        }
        : null,

        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Log In",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(236, 60, 3, 1),
                    Color.fromRGBO(234, 60, 3, 1),
                    Color.fromRGBO(216, 78, 16, 1),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget loginForm = Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child:_buildUsername(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: _buildPassword(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Widget signUp = Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t Have an Account? ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RegisterPage()));
            },
            child: Text(
              'SIGNUP',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Forgot your password? ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ForgotPasswordPage(),
                ),
              );
            },
            child: Text(
              'Reset password',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    return SafeArea(
      child: new Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                color: transparentYellow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(flex: 2),
                  welcomeBack,
                  Spacer(flex: 2),
                  subTitle,
                  Spacer(flex: 2),
                  loginForm,
                  Center(
                    child: loginButton,
                  ),
                  signUp,
                  Spacer(flex: 1),
                  forgotPassword,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
