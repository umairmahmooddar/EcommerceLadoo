import 'package:flutter_svg/flutter_svg.dart';
import 'package:superssecommerce/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:superssecommerce/components/rounded_input_field.dart';
import 'package:superssecommerce/components/rounded_password_field.dart';

import 'forgot_password_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController uname = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController cmfPassword = TextEditingController();

  bool username_Enable = false;
  bool pass_Enable = false;
  bool is_number = false;
  bool is_username = false;
  bool password_identifier;
  bool button_Enable = false;
  bool password_varified = false;
  bool cmf_pass = false;
  bool email_Enable = false;

  bool isPasswordAuthentic(String password) {
    int Length = 8;
    if (password.isEmpty) {
      return false;
    }
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasMinLength = password.length > Length;
    return hasDigits & hasUppercase & hasLowercase & hasMinLength;
  }


  Widget _builEmail() {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Email',

          icon: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
              child: Icon(Icons.person))),
      keyboardType: TextInputType.emailAddress,
      controller: email,
      onChanged: (String value) {
        setState(() {
          if ((RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value))) {
            email_Enable = true;
          } else {
            email_Enable = false;
          }
        });
      },
    );
  }

  Widget _buildUsername() {
    return TextField(
      enabled: email_Enable ? true : false,
      decoration: InputDecoration(
          labelText: 'UserNme / PhoneNumber',
          icon: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
              child: Icon(Icons.person))),
      controller: uname,
      onChanged: (String value) {
        setState(() {
          if ((RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value)) &&
              value.length >=10) {
            is_username = true;
          } else {
            is_username = false;
          }
          if (RegExp(r"/^[0-9]{11}$/").hasMatch(value)) {
            is_number = true;
          } else {
            is_number = false;
          }

          if (is_number == true || is_username == true) {
            username_Enable = true;
          } else {
            username_Enable = false;
          }
        });
      },
    );
  }

  Widget _buildcmfPassword() {
    return TextField(
      enabled: pass_Enable ? true : false,
      obscureText: true,
      controller: cmfPassword,
      decoration: InputDecoration(
        labelText: 'Conformation Password',
        icon: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
            child: Icon(Icons.lock)),
        errorText: isPasswordAuthentic(cmfPassword.text)
            ? PasswordVarification()
                ? 'Password Varified'
                : 'Please Enter The Same Password'
            : 'Please Enter Varified Password',
      ),
      onChanged: (String value) {
        setState(() {
          password_identifier = password.text.isNotEmpty;
          if (password_identifier == true) {
            cmf_pass = true;
            if (cmf_pass == true && username_Enable == true) {
              button_Enable = true;
            } else {
              button_Enable = false;
            }
          }
        });
        return null;
      },
    );
  }

  Widget _buildPassword() {
    return TextField(
      enabled: username_Enable ? true : false,
      obscureText: true,
      controller: password,
      decoration: InputDecoration(
        labelText: 'Password',
        icon: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
            child: Icon(Icons.lock)
        ),
        errorText: isPasswordAuthentic(password.text)
            ? 'Varified'
            : 'Please Enter Varified Password',
      ),
      onChanged: (String value) {
        setState(() {
          password_identifier = isPasswordAuthentic(value);
          if (password_identifier == true) {
            pass_Enable = true;
            if (pass_Enable == true && username_Enable == true) {
              button_Enable = true;
            } else {
              button_Enable = false;
            }
          }
        });
        return null;
      },
    );
  }

  bool PasswordVarification() {
    return (password.text == cmfPassword.text) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Glad To Meet You',
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
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Create your new account for future uses.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget registerButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 40,
      child: InkWell(
        onTap: PasswordVarification() && cmf_pass
            ? () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
              }
            : null,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 70,
          child: Center(
              child: new Text("Register",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: mainButton,
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

    Widget registerForm = Container(
      padding: EdgeInsets.only(bottom: 20),
      child: SingleChildScrollView(
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left:10,right: 20),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _builEmail(),
              _buildUsername(),
              _buildPassword(),
              _buildcmfPassword(),
            ],
          ),
        ),
      ),
    );

    Widget orDivider = Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.white,
              height: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.white,
              height: 2,
            ),
          ),
        ],
      ),
    );

    Widget socialRegister = Column(
      children: <Widget>[
        Text(
          'You can sign in with',
          style: TextStyle(
              fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  "assets/icons/facebook.svg",
                  height: 30,
                  width: 30,
                  color: Color(0xff3b5998),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  "assets/icons/twitter.svg",
                  height: 30,
                  width: 30,
                  color: Color(0xff00acee),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  "assets/icons/google-plus.svg",
                  height: 30,
                  width: 30,
                  color: Color(0xffdb4a39),
                ),
                onTap: () {},
              ),
            ),
          ],
        )
      ],
    );

    return Scaffold(
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: title,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: subTitle,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                registerForm,
                Center(child: registerButton),
                Center(child: orDivider),
                socialRegister,
              ],
            ),
          ),
          Positioned(
            top: 35,
            left: 5,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
