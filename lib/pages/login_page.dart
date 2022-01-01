import 'package:flutter/material.dart';
import 'package:kosan_app/pages/home_page.dart';
import 'package:kosan_app/providers/authentication.dart';
import 'package:kosan_app/pages/error_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // String email = 'user@mail.com';
  // String password = '123456';
  Color yellowColor = Color(0xffFFB942);
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(50),
                child: Image.asset(
                  'assets/logo-polosan - white.png',
                  scale: 2,
                ),
              ),
              _formBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formBuilder(){
    return Form(
      key: formKey,
      // autovalidate: true,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              validator: (value){
                return value.isEmpty ? "Email Tidak Boleh Kosong" : null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 10)
                ),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              validator: (value){
                return value.isEmpty ? "Password Tidak Boleh Kosong" : null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                ),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5),),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            child: FlatButton(
              onPressed: () {},
              child: Text(
                'Lupa Password ?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              // if (formKey.currentState.validate() && emailController.text.toString() == email {
              AuthenticationHelper()
                  .signIn(email: emailController.text.toString(), password: passwordController.text.toString())
                  .then((result) {
                if (result == null) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage(emailz: emailController.text.toString())), (Route<dynamic> route)=>false);
                } else {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ErrorLogin()), (Route<dynamic> route)=>false);
                }
              });

              // }
            },
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Center(
                child: Text('Login', style: TextStyle(
                    fontSize: 24,
                    color: yellowColor
                ),),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: FlatButton(
              child: Text('Buat akun', style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              ),),
              onPressed: (){
                AuthenticationHelper()
                    .signUp(email: emailController.text.toString(), password: passwordController.text.toString())
                    .then((result) {
                  if (result == null) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage(emailz: emailController.text.toString())), (Route<dynamic> route)=>false);
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        result,
                        style: TextStyle(fontSize: 16),
                      ),
                    ));
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}