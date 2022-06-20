import 'package:delayed_display/delayed_display.dart';
import 'package:ecom_daru/authentication/login/login-form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode contactNoFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool obsecureText = true;
  bool changeButton = false;

  String name = '';
  String password = '';
  String email = '';
  String contact = '';
  final validator = GlobalKey<FormState>();
  //Hide/Unhide Password function
  void showPassword() {
    setState(() {
      obsecureText = !obsecureText;
    });
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    contactNoFocusNode.dispose();
    super.dispose();
  }

  void submitForm() {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      auth.createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: password.trim(),
      );
    }
  }

  loginScreen(BuildContext context) async {
    if (validator.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(
        Duration(seconds: 1),
      );
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => LoginScreen()),
      );

      setState(
        () {
          changeButton = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue,
                Colors.blue.shade800,
                Colors.blue.shade400,
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    PlayAnimation<double>(
                      tween: Tween(begin: 0.0, end: 150.0),
                      duration: Duration(seconds: 1),
                      delay: Duration(seconds: 1),
                      curve: Curves.bounceInOut,
                      builder: (context, child, value) {
                        return Container(
                          width: value,
                          height: 50.0,
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: validator,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          DelayedDisplay(
                            delay: Duration(microseconds: 1),
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Name can\'t empty';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(),
                                    labelText: 'Name',
                                    hintText: 'Enter Name Here',
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: obsecureText,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password can\'t empty';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    suffixIcon: IconButton(
                                      onPressed: showPassword,
                                      icon: Icon(
                                        obsecureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    hintText: 'Enter Password Here',
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email can\'t empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                    hintText: 'Enter Email Here',
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Contact can\'t empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    border: OutlineInputBorder(),
                                    labelText: 'Contact',
                                    hintText: 'Enter Contact Here',
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),

                          /*  Material(
                                      color: Colors.blue,
                                      borderRadius:
                      BorderRadius.circular(changeButton ? 50 : 10),
                                      child: InkWell(
                                        onTap: () => loginScreen(context),
                                        child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: changeButton ? 50 : 150,
                      height: 50,
                      alignment: Alignment.center,
                      child: changeButton
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 2,
                              ),
                            ),
                                        ),
                                      ),
                                    ), */
                          DelayedDisplay(
                            delay: Duration(seconds: 2),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                minimumSize: Size(200, 50),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          DelayedDisplay(
                            delay: Duration(seconds: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
