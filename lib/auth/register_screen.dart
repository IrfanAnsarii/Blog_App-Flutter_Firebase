import 'package:blog/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final formkey=GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: formkey,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  const SizedBox(height: 100),
                  Text('Register', style: Theme.of(context).textTheme.displaySmall),
                  Text('Please Enter Name, email and Pass to get started',),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: 'Name',),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'Email',),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      hintText: 'Password: ',),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },

                  ),

                  const SizedBox(height: 30),
                  loading? const Center(child: CircularProgressIndicator(),) :
                  ElevatedButton(
                    onPressed: () {
                      if(formkey.currentState!.validate()){
                        setState(() {
                          loading=true;
                        });
                        startRegister();
                      }
                    },
                    child: const Text('Register'),
                  ),

                ],
              ),
            ),
          ),
          OutlinedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
            },
            child: const Text('Don\'t have an account? Create New Account'),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
  startRegister() async {
    try{
     final result = await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
     await result.user?.updateDisplayName(name.text);
     setState(() {
       loading=false;
     });
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const HomeScreen()), (route) => false);

    }on FirebaseAuthException catch(e){
      setState(() {
        loading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message?? ''),
          backgroundColor: Colors.red,
        ),
      );

    }
  }
}
