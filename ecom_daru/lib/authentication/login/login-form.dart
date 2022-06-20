
import 'package:delayed_display/delayed_display.dart';
import 'package:ecom_daru/authentication/register/register-form.dart';
import 'package:ecom_daru/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_animations/simple_animations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsecureText = true;
  bool changeButton = false;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  final validator = GlobalKey<FormState>();
  //Hide/Unhide Password function
  void showPassword() {
    setState(() {
      obsecureText = !obsecureText;
    });
  }

  /* moveToHomePage(BuildContext context) async {
    if (validator.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(
        Duration(seconds: 1),
      );
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => HomeScreen()),
      );

      setState(
        () {
          changeButton = false;
        },
      );
    }
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    tween: Tween(begin: 0.0, end: 100.0),
                    duration: Duration(seconds: 1),
                    delay: Duration(seconds: 1),
                    curve: Curves.decelerate,
                    builder: (context, child, value) {
                      return Container(
                        width: value,
                        height: 50.0,
                        child: Text(
                          "Login",
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
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: validator,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        DelayedDisplay(
                          delay: Duration(microseconds: 2),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Username Required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                  labelText: 'Username',
                                  hintText: 'Enter Username Here',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password Required';
                                  }
                                  return null;
                                },
                                obscureText: obsecureText,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: showPassword,
                                    icon: Icon(
                                      obsecureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.vpn_key),
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  hintText: 'Enter Password Here',
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
                    borderRadius: BorderRadius.circular(changeButton ? 50 : 10),
                    child: InkWell(
                      onTap: () => moveToHomePage(context),
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
                                'Login',
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        DelayedDisplay(
                          delay: Duration(seconds: 3),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password',
                            ),
                          ),
                        ),
                        DelayedDisplay(
                          delay: Duration(seconds: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Dont have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text('Sign Up'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DelayedDisplay(
                          delay: Duration(seconds: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Or'),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DelayedDisplay(
                          delay: Duration(seconds: 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/gmail.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/facebook.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/google.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                              /* Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    onPrimary: Colors.white,
                                    shadowColor: Colors.blueAccent,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    minimumSize: Size(200, 50),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Google',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    onPrimary: Colors.white,
                                    shadowColor: Colors.blueAccent,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    minimumSize: Size(200, 50), //////// HERE
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Facebook',
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ), */
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
        ),
        /* child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: validator,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(38.0),
                    //   height: 150,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username Required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter Username Here',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password Required';
                      }
                      return null;
                    },
                    obscureText: obsecureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showPassword,
                        icon: Icon(
                          obsecureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      prefixIcon: Icon(Icons.vpn_key),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password Here',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*  Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(changeButton ? 50 : 10),
                    child: InkWell(
                      onTap: () => moveToHomePage(context),
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
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 2,
                                ),
                              ),
                      ),
                    ),
                  ), */
                  ElevatedButton(
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
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Or'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            shadowColor: Colors.blueAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(200, 50),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Google',
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            shadowColor: Colors.blueAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(200, 50), //////// HERE
                          ),
                          onPressed: () {},
                          child: Text(
                            'Facebook',
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ), */
      ),
    );
  }
}
