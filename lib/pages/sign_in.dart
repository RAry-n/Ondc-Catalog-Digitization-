
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'ONDC',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(top: fem*70, bottom: fem*120),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(

                    color: Colors.white,
                  ),
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    icon: Icon(Icons.person),
                    iconColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0.0),
                child: TextField(
                  obscureText: hidePassword,
                  controller: passwordController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    icon: Icon(Icons.password),
                    iconColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility
                      ),
                      color: Colors.white,
                      onPressed: (){
                        setState(() {
                          print(hidePassword);
                          if(hidePassword) hidePassword = false;
                          else hidePassword = true;
                          // hidePassword = !hidePassword;
                        });
                      },
                    )
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: Text('Forgot Password?  ',
                    style: TextStyle(color: Colors.grey[200]),),
                ),
              ),
              Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('SIGN IN', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      String name = nameController.text;
                      String pass = passwordController.text;
                      signIn(name, pass);
                    },
                  )
              ),
              Row(
                children: <Widget>[
                  Container(
                    // height: 40.0,
                    padding: EdgeInsets.only(top: 10.5),
                    child: const Text('Does not have an account?',
                      style: TextStyle(color: Colors.white),),
                  ),
                  Container(
                    height:40.0,
                    // alignment: Alignment.topCenter,
                    child: TextButton(

                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.amber,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/sign_up');
                      },
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          )),
    );
  }

  Future<void> signIn(String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass
      );
      displaySnackBar('Signed in successfully!');
      Navigator.pushReplacementNamed(context, '/home');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displaySnackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        displaySnackBar('Wrong password provided for that user.');
      }
    }
  }

  void displaySnackBar(String s) {
    var snackdemo = SnackBar(
      content: Text(s),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }



}
