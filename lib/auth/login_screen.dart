import 'package:blog/auth/register_screen.dart';
import 'package:blog/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email=TextEditingController();
  final password=TextEditingController();
  final formkey=GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
  bool loading=false;
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
                  Text('LOGIN', style: Theme.of(context).textTheme.displaySmall),
                  Text('Please Enter email and Pass to get started',),
                  const SizedBox(height: 30),
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
                    obscureText: true,
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
                        startLogin();

                      }
                    },
                    child: const Text('Login'),
                  ),

                ],
              ),
            ),
          ),
          OutlinedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const RegisterScreen()));

              },
              child: const Text('Don\'t have an account? Create New Account'),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  startLogin() async {
    try{
      await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
      setState(() {
        loading=false;
      });
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const HomeScreen()), (route) => false);
    } on FirebaseAuthException catch(e){
      setState(() {
        loading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message?? ''),
          backgroundColor: Colors.red,
        )
      );

    }
  }
}
