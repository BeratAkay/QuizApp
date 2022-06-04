import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_application/helper/functions.dart';
import 'package:quiz_application/services/auth.dart';
import 'package:quiz_application/views/signup.dart';
import 'package:quiz_application/widgets/widgets.dart';

import 'home.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
   late String email, password;
   AuthService authService=new AuthService();

   bool _isLoading=false;


   singIn() async{
     if(formKey.currentState!.validate()){
       setState(() {
         _isLoading=true;
       });
      await  authService.signInEmailAndPass(email, password).then((val){
        if(val!=null){
          setState(() {
            _isLoading=false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=> Home ()
          ));
        }
      });

     }
   }





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,


      ),
      body: _isLoading ? Container (
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
             Spacer(),
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

              decoration:  InputDecoration(
                  hintText: "Password"
              ),
              onChanged: (val){
                password=val;
              },
            ),
              SizedBox(height: 24 ,),
              
              GestureDetector(
                onTap: () {
                  singIn();

                },
                child: blueButton(
                    context: context,
                    label: "Sing In"),
              ),




              SizedBox(height: 18 ,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center ,
                children: [
                Text("Don't have account" , style: TextStyle(fontSize: 15.5 ),),

                GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>SignUp()
                      ));
                    } ,

                    child: Text("Sign Up", style: TextStyle(fontSize: 15.5 ,decoration: TextDecoration.underline),))
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
    properties.add(StringProperty('email', email));
  }
}