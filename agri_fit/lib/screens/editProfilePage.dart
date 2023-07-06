import 'package:agri_fit/screens/profilePage.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({Key? key}) : super(key: key);

  static const route = '/editprofile/';
  static const routename = 'EditProfilePage';

  @override
  State<EditProfilePage> createState() {
    return _EditPageState();
}
}

class _EditPageState extends State<EditProfilePage>{

  final _textControllerName = TextEditingController();
  final _textControllerGen = TextEditingController();
  final _textControllerAge = TextEditingController();
  final _textControllerHeight = TextEditingController();
  final _textControllerWeight = TextEditingController();

  String editName = '';
  String editGen = '';
  String editAge = '';
  String editHeight = '';
  String editWeight = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Edit profile', textScaleFactor: 1.5,),
        foregroundColor: Colors.black,
      ),

      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 250, 250, 250),
                Color.fromARGB(255, 27, 179, 141),
              ]
            )
          ),
        
        
        child: Column(
          children: [
            const SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Container(
                height: 540,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color.fromARGB(255, 250, 250, 250)),
                
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createTextField('Name', 'Your name', _textControllerName),
            
                      const SizedBox(height: 16,),
                      createTextField('Gender', 'Gender (F/M)', _textControllerGen),
            
                      const SizedBox(height: 16,),
                      createTextField('Age', 'Your age', _textControllerAge),
                      
                      const SizedBox(height: 16,),
                      createTextField('Height', 'Your height (in cm)', _textControllerHeight),
                      
                      const SizedBox(height: 16),
                      createTextField('Weight', 'Your weight (in kg)', _textControllerWeight),
                      
                      const SizedBox(height: 26),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: const MaterialStatePropertyAll(Size(130, 50)),
                          elevation: const MaterialStatePropertyAll(0),
                          backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 237, 237, 237)),
                          foregroundColor: const MaterialStatePropertyAll(Colors.black),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                        ),
                        
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfilePage(editName : editName, editGen: editGen, editAge: editAge, editHeight: editHeight, editWeight: editWeight)));
                            _setText();
                            _setAge();
                            _setGen();
                            _setHeight();
                            _setWeight();
                          }, 
                        child: const Text('Save Changes')),
                    ],),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setText(){
    setState(() {
      editName = _textControllerName.text;
    });
  }

  void _setGen(){
    setState(() {
      editGen = _textControllerGen.text;
    });
  }

  void _setAge(){
    setState(() {
      editAge = _textControllerAge.text;
    });
  }

  void _setHeight(){
    setState(() {
      editHeight = _textControllerHeight.text;
    });
  }

  void _setWeight(){
    setState(() {
      editWeight = _textControllerWeight.text;
    });
  }
}


Widget createTextField(String labelText, String hintText, final textController){
  return 
  TextField(cursorColor: Colors.black,
  controller: textController,
  decoration: InputDecoration(
    border: const OutlineInputBorder(),

    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1, color: Colors.grey)),

    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1, color: Colors.black)),
    
    hintText: hintText,

    labelStyle: const TextStyle(
      color: Colors.grey,),
    labelText: labelText,)
    );            
  }