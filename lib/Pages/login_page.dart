

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> { 

  bool obscureText = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Container(
            height: 300, 
            width: double.infinity,
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
                children: [
                  
                  const SizedBox(height: 16.0),

                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined, size: 24),
                      hintText: "Email",
                      isDense: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                    ),
                  ),

                  const SizedBox(height: 6.0),

                  TextFormField(
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline, size: 24),
                      hintText: "Password",
                      isDense: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      suffixIcon: IconButton(
                        icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 24), 
                        onPressed: () => setState(() {
                          obscureText = !obscureText;
                        }),
                      ),
                    ),
                  ),

                  const SizedBox(height: 6.0),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password", style: TextStyle(color: Colors.blue),),
                  )
                ],
              )
            )
          )
        )
      ),
    );
  }
}