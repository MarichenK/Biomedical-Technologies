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
      appBar: AppBar(
        title: const Text('Edit Profile Page'),
      ),
      body: Padding(padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textControllerName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Full Name',
                labelText: 'Name'),
               
           ),
           const SizedBox(height: 16,),
           TextField(
              controller: _textControllerGen,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Gender (F/M)',
                labelText: 'Gender') 
           ),
           const SizedBox(height: 16,),
            TextField(
              controller: _textControllerAge,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Your age',
                labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: _textControllerHeight,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Your height (in cm)',
                labelText: 'Height'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textControllerWeight,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Your weight (in kg)',
                labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
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
          ],),),
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