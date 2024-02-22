

import 'package:comic_app/Backend/User.dart';
import 'package:comic_app/Pages/home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> { 

  bool obscureText = true; 

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool signingIn = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 330, 
          height: 330,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.secondaryContainer,
              width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.background,
            
          ),

          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
      
                const SizedBox(height: 8.0),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined, size: 24),
                    hintText: "Email",
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                  ),
                ),

                const SizedBox(height: 6.0),

                TextFormField(
                  controller: passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline, size: 24),
                    hintText: "Password",
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    suffixIcon: IconButton(
                      icon: Icon(obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 24), 
                      onPressed: () => setState(() {
                        obscureText = !obscureText;
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 6.0),

                SizedBox(
                  width: double.infinity,
                  child:TextButton(
                  onPressed: (){
                    signingIn = true; 
                    appUser.signInWithPassword(emailController.text, passwordController.text).then((value) {
                      if (value == false) {
                        print("Failed to sign user in");
                        signingIn = false; 
                        return;
                      }

                      Navigator.pushReplacement(context, PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(), 
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));
                    });
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(15) ))
                  ),
                  child: const Text("Sign In"))
                ),

                const SizedBox(height: 6.0),

                Row(
                  children: [
                    Expanded(child: Divider(color: Theme.of(context).colorScheme.secondaryContainer,)),
                    const SizedBox(width: 16),
                    const Text("Or"),
                    const SizedBox(width: 16),
                    Expanded(child: Divider(color: Theme.of(context).colorScheme.secondaryContainer)),
                  ],),

                  const SizedBox(height: 6.0),

                  SizedBox(
                  width: double.infinity,
                  child:TextButton(
                  onPressed: (){}, 
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(15) ))
                  ),
                  child: const Text("Register"))
                ),
              ],
            )
          )
        )
      ),
    );
  }
}