import 'package:flutter/material.dart';
import 'package:tictactoe/game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController Player1Controller = TextEditingController();
  final TextEditingController Player2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter Player Name",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: Player1Controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                        errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                  hintText: "Enter Player1 Name",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "please enter player1 name";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: Player2Controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  hintText: "Enter Player2 Name",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "please enter player2 name";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                if(_formKey.currentState!.validate()){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => GameScreen(
                          player1: Player1Controller.text,
                          player2: Player2Controller.text),
                  ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 17 ),
                  child: Text("Start Game",style: TextStyle(
                    fontSize: 24,
                    fontWeight:FontWeight.bold,
                    color: Colors.black,
                  ),),
                )
              ),
          ],
        ),
        
      ),

    );
  }
}
