import 'package:flutter/material.dart';
import 'package:quiz_application/services/database.dart';

import '../widgets/widgets.dart';

class AddQuestions extends StatefulWidget {
    late final String quizId;
    AddQuestions({Key? key}) : super(key: key);



  @override
  State<AddQuestions> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestions> {
  final formKey= GlobalKey<FormState>();
  late String Soru,A,B,C,D,E;
  bool _isLoading=false;

  DatabaseService databaseService=DatabaseService();

  uploadQuestionData()async{
    if(formKey.currentState!.validate()){

      setState(() {
        _isLoading=true;
      });



      Map<String,String>questionMap={
       "question": Soru,
        "A":A,
        "B":B,
        "C":C,
        "D":D



      };
      databaseService.addQuestionData(questionMap, widget.quizId).then((value) {

        setState(() {
          _isLoading=false;
        });



      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(

      title: appBar(context) ,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0.0,

    ) ,

      body: _isLoading ? Container(
        child: Center(child: CircularProgressIndicator(),),
      ): Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            TextFormField(
              validator: (val) =>
              val!.isEmpty ? "Lütfen Soruyu Yazınız":null,
              decoration: const InputDecoration(
                hintText: "Soruyu Yazınız",
              ),

              onChanged: (val){
                Soru=val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val!.isEmpty ?"A seçeneği": null,
              decoration: const InputDecoration(
                hintText: "A seçeneği",
              ),

              onChanged: (val){
                A=val;
              },
            ),
            SizedBox(height: 6,),

            TextFormField(
              validator: (val) =>
              val!.isEmpty ? "Lütfen B seçeneği girin":null,
              decoration: const InputDecoration(
                hintText: "B seçeneği",
              ),

              onChanged: (val){
                B=val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val!.isEmpty ?"C seçeneği": null,
              decoration: const InputDecoration(
                hintText: "C seçeneği",
              ),

              onChanged: (val){
                C=val;
              },
            ),
            SizedBox(height: 6,),

            TextFormField(
              validator: (val) => val!.isEmpty ?"D seçeneğini giriniz": null,
              decoration: const InputDecoration(
                hintText: "D seçeneği",
              ),

              onChanged: (val){
                D=val;
              },
            ),
            Spacer(),
            
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },

                  child: blueButton(context: context, label: "Kaydet",
                    buttonWidth: MediaQuery.of(context).size.width/2-36
                  ),
                ),
                SizedBox(width: 24,),

                GestureDetector(
                  onTap: (){
                    uploadQuestionData();
                  },
                  child: blueButton(context: context, label: "Soru Ekle",
                      buttonWidth: MediaQuery.of(context).size.width/2-36
                  ),
                )
              ],
            ),
            SizedBox(height: 50,),
            
          ],),
        ),
      ),
    );
  }
}

