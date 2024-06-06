// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _firebase = FirebaseAuth.instance;

Color blueColors = const Color.fromARGB(255, 28, 104, 210);
Color blueLightColors = const Color.fromARGB(255, 24, 106, 221);

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool _passwordVisible = false;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  ///   CRUD

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredConfirmPassword = '';
  var _enteredFirstName = '';
  var _enteredLastName = '';
  var _enteredPhoneNumber = '';
  // var _isAuthenticating = false;

  void _submitCredentials() async {
    setState(() {
      _isloading = true;
    });

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      setState(() {
        _isloading = false;
      });
      return;
    }

    _formKey.currentState!.save();

    try {
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userSignUp = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userSignUp.user!.uid)
            .set({
          'Firstname': _enteredFirstName,
          'Lastname': _enteredLastName,
          'email': _enteredEmail,
          'Password': _enteredPassword,
          'Phone Number': _enteredPhoneNumber,
          'Confirmed Password': _enteredConfirmPassword,
        });
      }

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const BottomAppBar()));
    } on FirebaseAuthException catch (error) {
      print('FirebaseAuthException code: ${error.code}');

      String errorMessage = 'Authentication failed.';
      if (error.code == 'wrong-password') {
        errorMessage = 'Authentication failed. Wrong password.';
      } else if (error.code == 'invalid-credential') {
        errorMessage = 'Authentication failed. Invalid email.';
      } else if (error.code == 'user-not-found') {
        errorMessage = 'Authentication failed. User not found.';
      } else if (error.code == 'email-already-in-use') {
        errorMessage = 'Authentication failed. Email already in use.';
      } else if (error.code == 'user-disabled') {
        errorMessage = 'Authentication failed. This User has been disabled.';
      } else if (error.code == ' too-many-requests') {
        errorMessage =
            'Authentication failed. Wrong Password, too many requests.';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.blue,
      ));
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              HeaderContainer(_isLogin
                  ? "News And Blog Mobile Application"
                  : "Let's help you Register"),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (!_isLogin)
                          Flexible(
                            child: _textInput(
                              icon: Icons.person,
                              hint: 'First Name',
                              keyboardType: TextInputType.name,
                              textFormatter: [CapitalizingText()],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' Enter Your First Name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredFirstName = value!;
                              },
                            ),
                          ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        if (!_isLogin)
                          Flexible(
                            child: _textInput(
                              icon: Icons.person,
                              hint: 'Last Name',
                              keyboardType: TextInputType.name,
                              textFormatter: [CapitalizingText()],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' Enter Your Last Name';
                                }
                              },
                              onSaved: (value) {
                                _enteredLastName = value!;
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              _textInput(
                icon: Icons.email,
                hint: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This Space Must not be empty';
                  }
                  if (!value.contains('@')) {
                    return 'Enter a valid email address';
                  }
                  final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }

                  return null;
                },
                onSaved: (value) {
                  _enteredEmail = value!;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              if (!_isLogin)
                _textInput(
                  icon: Icons.phone,
                  hint: 'Phone',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Space Must not be empty';
                    }

                    if (value.trim().length < 11) {
                      return ' Enter a valid Phone Number. ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredPhoneNumber = value!;
                  },
                ),
              const SizedBox(
                height: 15.0,
              ),
              _textInput(
                controller: password,
                icon: Icons.vpn_key,
                hint: 'Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password looks Empty';
                  }
                  if (_isLogin == false && value.trim().length < 6) {
                    return 'Password Must be Atleast 6 Characters Long.';
                  }
                  if (_isLogin == false && !value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password Must have an upperCase letter';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredPassword = value!;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              if (!_isLogin)
                _textInput(
                  controller: confirmpassword,
                  icon: Icons.vpn_key,
                  hint: 'Confirm Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Confirm your Password';
                    }
                    if (password.text != confirmpassword.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredConfirmPassword = value!;
                  },
                ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: _isloading
                    ? const CircularProgressIndicator()
                    : ButtonWidget(
                        buttonText: _isLogin ? "LOG IN" : 'SIGN UP',
                        onClick: () {
                          _submitCredentials();
                        },
                      ),
              ),
              const SizedBox(
                height: 0.2,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLogin ? ' Are you New ?' : 'Already a Member ?',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 1.0,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin ? 'Create an account!' : 'Sign in',
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textInput({
    controller,
    hint,
    icon,
    keyboardType,
    validator,
    onSaved,
    obscureText,
    suffixIcon,
    List<TextInputFormatter>? textFormatter,
  }) {
    bool isObscured = obscureText ?? false;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: textFormatter,
        validator: validator,
        onSaved: onSaved,
        controller: controller,
        obscureText: isObscured,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

class HeaderContainer extends StatelessWidget {
  final String text;

  const HeaderContainer(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [blueColors, blueLightColors],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100)),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Center(
            child: Image.asset(
              "Assets/images/logo.png",
              height: 250,
              width: 250,
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onClick;

  const ButtonWidget({
    super.key,
    required this.buttonText,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        width: 350,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [blueColors, blueLightColors],
            end: Alignment.centerLeft,
            begin: Alignment.centerRight,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
// whaat if there is a program to decode the system into a fine dictative set for the user to adapt and comprehent. Dont play

class CapitalizingText extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.capitalizeFirstLetter(),
      selection: newValue.selection,
    );
  }
}

extension StringCapitalization on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
