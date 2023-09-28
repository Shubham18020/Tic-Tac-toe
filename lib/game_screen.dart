import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  String player1;
  String player2;

  GameScreen({required this.player1,required this.player2});

  //const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _Gameover;

  @override
  void initState(){
    super.initState();
    _board= List.generate(3, (_)=> List.generate(3, (_)=>" "));
    _currentPlayer="X";
    _winner="";
    _Gameover=false;
  }

  void _resetgame(){
    setState(() {
      _board= List.generate(3, (_)=> List.generate(3, (_)=>" "));
      _currentPlayer="X";
      _winner="";
      _Gameover=false;

    });
  }
  void _makeMove(int row,int col){
    if(_board[row][col]!= "" || _Gameover){
      return;
    }
    setState(() {
      _board[row][col] = _currentPlayer;

      if(_board[row][0]==_currentPlayer &&
          _board[row][1]==_currentPlayer &&
          _board[row][2]==_currentPlayer
      ){
         _winner=_currentPlayer;
         _Gameover=true;
      }
      else if(_board[0][col]==_currentPlayer &&
          _board[1][col]==_currentPlayer &&
          _board[2][col]==_currentPlayer
      ){
        _winner=_currentPlayer;
        _Gameover=true;
      }
      if(_board[0][0]==_currentPlayer &&
          _board[1][1]==_currentPlayer &&
          _board[2][2]==_currentPlayer
      ){
        _winner=_currentPlayer;
        _Gameover=true;
      }
      if(_board[0][2]==_currentPlayer &&
          _board[1][1]==_currentPlayer &&
          _board[2][0]==_currentPlayer
      ){
        _winner=_currentPlayer;
        _Gameover=true;
      }
      //swictch player
      _currentPlayer=_currentPlayer=="X"?"O":"X";

      //check for tie
      if(_board.any((row) => row.any((cell) => cell == ""))){
        _Gameover=true;
        _winner="Game tie";
      }
      if(_winner!=""){
        AwesomeDialog(context: context,
        dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: "Play Again",
          title: _winner=="X"?widget.player1 + "Won!" : _winner=="O"?widget.player2 + "Won!"
              : "Game tie",
          btnOkOnPress: (){
          _resetgame();
          },
        )
          .show();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 70,),
          SizedBox(height: 120,child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Turn:",style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
                Text(
                  _currentPlayer=="X"
                      ? widget.player1 + " ($_currentPlayer)"
                      : widget.player2 + " ($_currentPlayer)",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _currentPlayer == "X"
                        ? Colors.deepOrange
                        : Colors.limeAccent,
                  ),)
              ],
            ),
            SizedBox(height: 20,),
          ],),
          ),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(5),
            child: GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ), itemBuilder: (context,index){
              int row = index ~/3;
              int col = index % 3;
              return GestureDetector(
                onTap: ()=>_makeMove(row, col),
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _board[row][col],
                      style: TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        color: _board[row][col]=="X"
                            ? Colors.deepOrange
                            : Colors.limeAccent,
                      ),
                    ),
                  ),
                ),
              );
            },
            ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: _resetgame,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                  child: Text("Reset Game",style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                ),
              )
            ],
          )
        ],),
      ),

    );
  }
}
