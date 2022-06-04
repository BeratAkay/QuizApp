import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_application/services/auth.dart';
import 'package:quiz_application/views/singin.dart';

import '../helper/functions.dart';
import '../widgets/widgets.dart';
import 'home.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formKey = GlobalKey<FormState>();
  late String name,email, password;
  AuthService authService= new AuthService();
  late bool _isLoading =false;

  
  signUp()async{
    if(formKey.currentState!.validate()){

      setState(() {
        _isLoading=true;
      });

      authService.signUpWithEmailAndPassword(email, password).then((value) {
        if(value!=null)
          {
            setState(() {
              _isLoading=false;
            });
            HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Home()
            ));
          }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,

      ),
      body: _isLoading ? Container(
        child: Center(child:CircularProgressIndicator() ,),
      ) : Form(
        key: formKey,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Spacer(),
                TextFormField(
                  validator: (val){return val!.isEmpty ? "Enter Name" : null;},

                  decoration:  const InputDecoration(
                      hintText: "Name"
                  ),
                  onChanged: (val){
                   name=val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val){return val!.isEmpty ? "Enter Email" : null;},

                  decoration:  const InputDecoration(
                      hintText: "Email"
                  ),
                  onChanged: (val){
                    email=val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  obscureText: true,
                  validator: (val){return val!.isEmpty ? "Enter Password" : null;},

                  decoration:  const InputDecoration(
                      hintText: "Password"
                  ),
                  onChanged: (val){
                    password=val;
                  },
                ),
                const SizedBox(height: 24 ,),
                GestureDetector(
                  onTap: (){
                    signUp();
                  },
                  child: blueButton(
                      context: context,
                      label: "Sign Up"
                  ),
                ),
                const SizedBox(height: 18 ,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center ,
                  children:  [
                    const Text("Already have and account?" , style: TextStyle(fontSize: 15.5 ),),

                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>SignIn()
                        ));
                      } ,
                        child: const Text("Sign In", style: TextStyle(fontSize: 15.5 ,decoration: TextDecoration.underline),))
                  ],
                ),
                SizedBox(height: 80,),



              ],)
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('_isLoading', _isLoading));
  }
}
