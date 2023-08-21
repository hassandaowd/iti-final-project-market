import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iti_final_project/layout/home_layout.dart';
import 'package:iti_final_project/login/register_screen.dart';
import 'package:iti_final_project/shared/cache_helper.dart';
import 'package:iti_final_project/shared/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool showPassword = true;
  late bool emailValid;
  bool loadingLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Login now to browse our hot offers',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email address must not be empty';
                      }
                      if (!emailValid && value.isNotEmpty) {
                        return 'Wrong email address format';
                      }
                      return null;
                    },
                    // onFieldSubmitted: (value) {
                    //   emailValid = RegExp(
                    //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //       .hasMatch(value);
                    // },
                    // onTapOutside: (value) {
                    //   emailValid = RegExp(
                    //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //       .hasMatch(emailController.text);
                    // },

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: showPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: showPassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                    onFieldSubmitted: (value) async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loadingLogin = false;
                        });
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        ).then((value) {
                          setState(() {
                            loadingLogin = true;
                          });
                          CacheHelper.saveData(key: 'token', value: value.user?.uid).then((state) {
                            token = value.user!.uid;
                            email = emailController.text;
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeLayout()),
                                  (route) => false,
                            );
                            CacheHelper.saveData(key: 'email', value: emailController.text);
                          });
                          toast(
                            msg: "Login Successfully",
                            state: ToastState.success,
                          );
                        }).catchError((error){
                          setState(() {
                            loadingLogin = true;
                          });
                          // no user -----> [firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.

                          toast(
                            msg: error.toString(),
                            state: ToastState.error,
                          );
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ConditionalBuilder(
                    condition: loadingLogin,
                    builder: (context) => Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: defaultColor,
                      ),
                      child: MaterialButton(
                        textColor: Colors.white,
                        child: Text(
                          'Login'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text);

                          if (formKey.currentState!.validate()) {
                            setState(() {
                              loadingLogin = false;
                            });
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            ).then((value) {
                              setState(() {
                                loadingLogin = true;
                              });
                              CacheHelper.saveData(key: 'token', value: value.user?.uid).then((state) {
                                token = value.user!.uid;
                                email = emailController.text;
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomeLayout()),
                                      (route) => false,
                                );
                                CacheHelper.saveData(key: 'email', value: emailController.text);
                              });
                              toast(
                                msg: "Login Successfully",
                                state: ToastState.success,
                              );
                            }).catchError((error){
                              setState(() {
                                loadingLogin = true;
                              });
                              // no user -----> [firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.

                              toast(
                                msg: error.toString(),
                                state: ToastState.error,
                              );
                            });
                          }
                        },
                      ),
                    ),
                    fallback: (context) => const Center(child: CircularProgressIndicator())),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an Account?  '),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'register now'.toUpperCase(),
                          style: const TextStyle(
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
