import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}
class MyBlinkingButton extends StatefulWidget {
  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  @override
  void initState() {
    AnimationController _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController!,
      child: Expanded(child: Image.asset('assets/images/live_sign_wbr.png')),

    );
  }

  @override
  void dispose() {
    _animationController?.dispose();

    super.dispose();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Squash Scoring Software - 31 EME Bn'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter1 = 0;
  int _counter2 = 0;
  int _limit_c1 = 10;
  int _limit_c2 = 10;
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  var _controllerB1Name = TextEditingController();
  var _controllerB2Name = TextEditingController();
  var _controllerBowler = TextEditingController();
  double _curr_over = 0.0;
  double _temp_curr_over = 0.0;
  double _temp_over_decimalPart = 0.0;
  int _totalBallsInNos = 0;
  int _temp_over_intPart = 0;
  double _total_over = 12.0;
  double remaining_over_D = 12.0;
  double req_runrate = 7.7;
  double curr_runrate = 2.3;
  bool setResetFlag = false;
  double f1 = 300;
  bool rememberMe = false;
  bool rememberMe2ndInning = true;
  bool checkBoxVisValue = true;
  bool checkBoxVisValueMaster = false;
  final TotalOversController = TextEditingController(text: '12');
  final TotalScoreController = TextEditingController(text: '200');
  int B1Runs = 0;
  int B1Balls = 0;
  int B2Runs = 0;
  int B2Balls = 0;
  double _bowlerOvers = 0.0;
  int _bowlerRuns = 0;
  int _bowlerWickets = 0;
  int _totalRuns = 0;
  int _totalWickets = 0;
  get value => null;

  @override
  void initState() {
    super.initState();
    //TotalScoreController = new TextEditingController(text: '200');
  }
  void _incrementRunsB1(){
    setState(() {B1Runs = B1Runs + 1;});
  }
  void _incrementBallsB1(){
    setState(() {B1Balls = B1Balls + 1;});
  }
  void _incrementRunsB2(){
    setState(() {B2Runs = B2Runs + 1;});
  }
  void _incrementBallsB2(){
    setState(() {B2Balls = B2Balls + 1;});
  }
  void _decrementRunsB1(){
    setState(() {
      B1Runs = B1Runs - 1;
      if (B1Runs == -1) {
        B1Runs = 0;
      }
    }
    );
  }
  void _totalOverLatch(){
    _currRunRate();
    setState((){
      //remaining_over_D = (double.parse(TotalOversController.text) - _curr_over) + 0.01;
      String dumbStr = (((double.parse(TotalOversController.text) - _curr_over) + 0.01)-0.5).toStringAsFixed(1); // '2.35'
      remaining_over_D = double.parse(dumbStr);
      if(remaining_over_D < 0 )
        {
          remaining_over_D = 0;
        }
      if(_curr_over>(double.parse(TotalOversController.text))){
        _curr_over = (double.parse(TotalOversController.text))-0.1;
      }
      _curr_over = _curr_over;
    }
    );
    _reqRunRate();
    //_currRunRate();
  }

  void _reqRunRate(){
    setState(() {
      req_runrate = ((int.parse(TotalScoreController.text) - _totalRuns))/remaining_over_D;
    });
  }
  void _currRunRate(){
    setState(() {
      _temp_curr_over = _curr_over + 0.1;
      _temp_over_intPart = (_temp_curr_over).floor();
      _temp_over_decimalPart = _temp_curr_over - _temp_over_intPart;
      _totalBallsInNos = _temp_over_intPart * 6 + (_temp_over_decimalPart * 10).round();
      curr_runrate = (_totalRuns / _totalBallsInNos)*6;
    });
  }
  void _decrementBallsB1() {
    setState(() {
      B1Balls = B1Balls - 1;
      if (B1Balls == -1) {
        B1Balls = 0;
      }
    }
    );
  }
  void _decrementRunsB2(){
    setState(() {
      B2Runs = B2Runs - 1;
      if (B2Runs == -1) {
        B2Runs = 0;
      }
    }
    );
  }
  void _decrementBallsB2() {
    setState(() {
      B2Balls = B2Balls - 1;
      if (B2Balls == -1) {
        B2Balls = 0;
      }
    }
    );
  }

  void _incrementBowlerRuns(){
    setState(() {_bowlerRuns = _bowlerRuns + 1;});
  }

  void _decrementBowlerRuns() {
    setState(() {
      _bowlerRuns = _bowlerRuns - 1;
      if (_bowlerRuns == -1) {
        _bowlerRuns = 0;
      }
    }
    );
  }
  final fc = FocusNode();
  void _clearControllers()
  {
    _controller1.clear();
    _controller2.clear();
    _controllerB1Name.clear();
    _controllerB2Name.clear();
    _controllerBowler.clear();
  }

  void _clearTeams()
  {
    _controller1.clear();
    _controller2.clear();
  }
  void _clearRunrateandOversControllers(){
    setState(() {
      _curr_over = 0.0;
      curr_runrate = 0.0;
      remaining_over_D = double.parse(TotalOversController.text);
      //TotalScoreController.text(TotalScoreController.text);
    });

  }
  void _incRemainingOver(){
      remaining_over_D = remaining_over_D + 0.1;
  }

    void _incCurrentOver(){
    _totalOverLatch();
    setState(() {
      _curr_over = _curr_over + 0.1;
      if(_curr_over > double.parse(TotalOversController.text))
        {
          _curr_over = _curr_over - 0.1;
        }
      String inString = _curr_over.toStringAsFixed(1); // '2.35'
      _curr_over = double.parse(inString);
      double decipart = _curr_over % 1;
      String inString2 = decipart.toStringAsFixed(1); // '2.35'
      decipart = double.parse(inString2);
      //print (decipart.toString());
      if (decipart == 0.6)   //check condition if we find that after decimal no is 0.7 we add 0.3
       {  print('I am here');
          _curr_over = _curr_over+0.4;
          if (_curr_over%1 == 0.0)
            {
              print (_curr_over.toInt().toString());
            }
        }
    });

  }
  void _incBowlerOver(){
    setState(() {
      _bowlerOvers = _bowlerOvers  + 0.1;
      String inString = _bowlerOvers.toStringAsFixed(1); // '2.35'
      _bowlerOvers  = double.parse(inString);
      double decipart = _bowlerOvers  % 1;
      String inString2 = decipart.toStringAsFixed(1); // '2.35'
      decipart = double.parse(inString2);
      //print (decipart.toString());
      if (decipart == 0.6)   //check condition if we find that after decimal no is 0.7 we add 0.3
          {  print('I am here');
      _bowlerOvers  = _bowlerOvers +0.4;
      if (_bowlerOvers %1 == 0.0)
      {
        print (_bowlerOvers .toInt().toString());
      }
      }
    });
  }
  void _incrementBowlerWickets(){
    setState(() {_bowlerWickets = _bowlerWickets + 1;});
  }
  void _decrementBowlerWickets() {
    setState(() {
      _bowlerWickets = _bowlerWickets - 1;
      if (_bowlerWickets == -1) {
        _bowlerWickets = 0;
      }
    }
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    TotalOversController.dispose();
    super.dispose();
  }
  void _decCurrentOver(){
    setState(() {
      _curr_over = _curr_over - 0.1;
      if(_curr_over<0){
        _curr_over = 0.0;
      }
      String inString = _curr_over.toStringAsFixed(1); // '2.35'
      _curr_over = double.parse(inString);
      double decipart = _curr_over % 1;
      String inString2 = decipart.toStringAsFixed(1); // '2.35'
      decipart = double.parse(inString2);
      //print (decipart.toString());
      if (decipart == 0.9)   //check condition if we find that after decimal no is 0.7 we add 0.3
          {  print('I am here');
      _curr_over = _curr_over-0.4;
      if (_curr_over%1 == 0.0)
      {
        print (_curr_over.toInt().toString());
      }
      }
    });
  }
  void _decBowlerOver(){
    setState(() {
      _bowlerOvers = _bowlerOvers - 0.1;
      String inString = _bowlerOvers.toStringAsFixed(1); // '2.35'
      _bowlerOvers = double.parse(inString);
      double decipart = _bowlerOvers % 1;
      String inString2 = decipart.toStringAsFixed(1); // '2.35'
      decipart = double.parse(inString2);
      //print (decipart.toString());
      if (decipart == 0.9)   //check condition if we find that after decimal no is 0.7 we add 0.3
          {  print('I am here');
      _bowlerOvers = _bowlerOvers-0.4;
      if (_bowlerOvers%1 == 0.0)
      {
        print (_bowlerOvers.toInt().toString());
      }
      }
    });
  }
  void _incrementTotalWickets(){
    setState(() {_totalWickets = _totalWickets + 1;});
  }
  void _decrementTotalWickets() {
    setState(() {
      _totalWickets = _totalWickets - 1;
      if (_totalWickets == -1) {
        _totalWickets = 0;
      }
    }
    );
    _reqRunRate();
  }
  void _incrementTotalRuns(){
    setState(() {_totalRuns = _totalRuns+ 1;});
  }
  void _decrementTotalRuns() {
    setState(() {
      _totalRuns= _totalRuns- 1;
      if (_totalRuns == -1) {
        _totalRuns = 0;
      }
    }
    );
  }
  void _incrementCounter1() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter1++;
      if (_counter1==9 && _counter2==8 )
      {
        _limit_c1 = 20;
        _limit_c2 = 20;
        f1 = 180;
      }
      if(_counter1==_limit_c1)
      {
        _counter1=9;
      }
    });
  }
  void _decCounter1() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter1--;
      if(_counter1==-1)
      {
        _counter1=0;
      }
    });
  }
  void _decCounter2() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter2--;
      if(_counter2==-1)
      {
        _counter2=0;
      }
    });
  }
  void _incrementCounter2() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter2++;
      if (_counter1==8 && _counter2==9 )
      {
        _limit_c1 = 20;
        _limit_c2 = 20;
        f1 = 150;
      }
      if(_counter2==_limit_c2)
      {
        _counter2=9;
      }
    });
  }
  void _resetCounters() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter1 = 0;
      _counter2 = 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: null,
      /*appBar: AppBar(
        title: Text("SCORE MANAGEMENT APPLICATION"),
        centerTitle: true,
      ),*/
      body: RawKeyboardListener(
        focusNode: fc,
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {  // for Player 2 inc
            // if (event is RawKeyDownEvent) {
            _incrementCounter2();
            print("I am pressed");
            // }
          }
          if (event.isKeyPressed(LogicalKeyboardKey.arrowDown )) {  // for Player 2 dec
            _decCounter2();
          }
          if (event.isKeyPressed(LogicalKeyboardKey.keyW)) {  // for Player 2 dec
            _incrementCounter1();
          }
          if (event.isKeyPressed(LogicalKeyboardKey.keyS)) {  // for Player 2 dec
            _decCounter1();
          }
          if (event.isKeyPressed(LogicalKeyboardKey.keyM)) {  // for Score Increment
            _incrementTotalRuns();
          }
        },
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgr.png"),
                fit: BoxFit.cover,
              ),
            ),

            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //child: Text("Behzad"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Image.asset('assets/images/div_s.png')),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("SCORE BD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60,decoration: TextDecoration.underline,), ),
                        Text("FRIENDLY CRICKET MATCH", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60,decoration: TextDecoration.underline,), ),
                      ],
                    ),
                    Expanded(child: Image.asset('assets/images/unit_s.png')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: TextField(
                      controller: _controller1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                       // border: OutlineInputBorder(),
                        hintText: 'Team Alpha',
                      ),
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),),
                    Expanded(
                      child: TextField(
                        controller: _controller2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                         // border: OutlineInputBorder(),
                         /* border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,*/
                          hintText: 'Team Bravo',
                        ),
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height:3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width:300, child: TextField(
                              controller: _controllerB1Name,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Batsman 1', ),
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),

                            ),
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: TextButton(
                                      /*style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                //textStyle: TextStyle(fontSize: 30),
                              ),*/
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          textStyle: const TextStyle(fontSize: 25)),
                                      onPressed: _decrementRunsB1,
                                      child: Text('Runs:'),
                                    ),
                                    ),
                                    Expanded(child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      ),
                                      onPressed: _incrementRunsB1,
                                      child: Text(B1Runs.toString(), style: TextStyle( fontSize: 30)),
                                    ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: TextButton(
                                      /*style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                //textStyle: TextStyle(fontSize: 30),
                              ),*/
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          textStyle: const TextStyle(fontSize: 25)),
                                      onPressed: _decrementBallsB1,
                                      child: Text('Balls:'),
                                    ),
                                    ),
                                    Expanded(child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      ),
                                      onPressed: _incrementBallsB1,
                                      child: Text(B1Balls.toString(), style: TextStyle( fontSize: 30) ),
                                    ),
                                    ),
                                  ],
                                ),

                              ],
                            )),
                          ],

                        ),
                        SizedBox(height:4),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width:300, child: TextField(
                              controller: _controllerB2Name,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Batsman 2', ),
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),

                            ),
                            Expanded(child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: TextButton(
                                      /*style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                //textStyle: TextStyle(fontSize: 30),
                              ),*/
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          textStyle: const TextStyle(fontSize: 25)),
                                      onPressed: _decrementRunsB2,
                                      child: Text('Runs:'),
                                    ),
                                    ),
                                    Expanded(child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      ),
                                      onPressed: _incrementRunsB2,
                                      child: Text(B2Runs.toString(),style: TextStyle( fontSize: 30) ),
                                    ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: TextButton(
                                      /*style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                //textStyle: TextStyle(fontSize: 30),
                              ),*/
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          textStyle: const TextStyle(fontSize: 25)),
                                      onPressed: _decrementBallsB2,
                                      child: Text('Balls:'),
                                    ),
                                    ),
                                    Expanded(child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      ),
                                      onPressed: _incrementBallsB2,
                                      child: Text(B2Balls.toString(),style: TextStyle( fontSize: 30) ),
                                    ),
                                    ),
                                  ],
                                ),

                              ],
                            )),
                          ],

                        ),
                      ],
                    ),
                    ),
                    //Expanded(child: TextButton(onPressed: _clearControllers, child: Text('Its me'),),),


                    Expanded(child:SizedBox(
                      width: 10,
                      child: Text("     Vs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 120,),), ),),
                    Expanded(child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height:6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width:300, child: TextField(
                              controller: _controllerBowler,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Bowler', ),
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),

                            ),
                            Expanded(child: Column(
                             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: TextButton(
                                      /*style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                //textStyle: TextStyle(fontSize: 30),
                              ),*/
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          textStyle: const TextStyle(fontSize: 20)),
                                      onPressed: _decBowlerOver,
                                      child: Text('Overs:'),
                                    ),
                                    ),
                                    Expanded(child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      ),
                                      onPressed: _incBowlerOver,
                                      child: Text(_bowlerOvers.toString(), style: TextStyle( fontSize: 30) ),
                                    ),
                                    ),
                                  ],
                                ),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: TextButton(
                                      /*style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                //textStyle: TextStyle(fontSize: 30),
                              ),*/
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          textStyle: const TextStyle(fontSize: 20)),
                                      onPressed: _decrementBowlerRuns,
                                      child: Text('Runs:'),
                                    ),
                                    ),
                                    Expanded(child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      ),
                                      onPressed: _incrementBowlerRuns,
                                      child: Text(_bowlerRuns.toString(), style: TextStyle( fontSize: 30)),
                                    ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: TextButton(
                                    style: TextButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          textStyle: const TextStyle(fontSize: 18)),
                                      onPressed: _decrementBowlerWickets,
                                      child: Text('Wicket:'),
                                    ),
                                    ),
                                    Expanded(child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      ),
                                      onPressed: _incrementBowlerWickets,
                                      child: Text(_bowlerWickets.toString(),style: TextStyle( fontSize: 30)),
                                    ),
                                    ),
                                  ],
                                ),

                              ],
                            )),
                          ],

                        ),
                        SizedBox(height:4),

                      ],
                    ),
                    ),
                    //Expanded(child: Text("Ballers Area", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60,decoration: TextDecoration.underline,), ), ),
                  ],),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: checkBoxVisValue,
                      child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black87,
                          textStyle: const TextStyle(fontSize: 25)),
                      onPressed: _clearControllers,
                      child: Text('Req Runs:'),
                    ),
                    ),
                    Visibility(
                      visible: checkBoxVisValue,
                      child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black87,
                          textStyle: const TextStyle(fontSize: 25)),
                      onPressed: _clearControllers,
                      child: Text((int.parse(TotalScoreController.text) - _totalRuns).toString()),
                      ),),
                    Visibility(
                      visible: true,
                      child: TextButton(

                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black87,
                          textStyle: const TextStyle(fontSize: 25)),
                      onPressed: _incRemainingOver,
                      child: Text('Remaining Overs:'),
                    ),),
                    Visibility(
                      visible: true,
                      child: TextButton(
                      /*style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                //textStyle: TextStyle(fontSize: 30),
                              ),*/
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black87,
                          textStyle: const TextStyle(fontSize: 25)),
                      onPressed: _totalOverLatch,
                      //child: Text('20'),
                      child: Text(remaining_over_D.toString()),
                    ),
                      ),
                    Visibility(
                      //visible: rememberMe2ndInning,
                      visible: checkBoxVisValue,
                      child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black87,
                          textStyle: const TextStyle(fontSize: 25)),
                      onPressed: _decrementTotalRuns,
                      child: Text('Req Run Rate:'),
                        //
                    ),
                    ),
                    Visibility(
                      visible: checkBoxVisValue,
                      child: TextButton(
                      style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                      textStyle: const TextStyle(fontSize: 25)),
                      onPressed: _decrementTotalWickets,
                      child: Text(req_runrate.toStringAsFixed(1).toString()),
                    ),)
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black87,
                            side: BorderSide(width: 1.0),
                            textStyle: const TextStyle(fontSize: 25)),
                        onPressed: _incrementTotalWickets,
                        child: Text('Total Runs/ Out'),

                      )
                      ),
                      Expanded(child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black87,
                            side: BorderSide(width: 1.0),
                            textStyle: const TextStyle(fontSize: 25)),
                        onPressed: _incrementTotalRuns,
                        child: Text('$_totalRuns'+' / '+'$_totalWickets'),
                      )
                      ),
                    ],
                    ),),

                    Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: TextButton(
                          /*style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                //textStyle: TextStyle(fontSize: 30),
                              ),*/
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(width: 1.0),
                              textStyle: const TextStyle(fontSize: 25)),
                          onPressed: _clearControllers,
                          child: Text('Run Rate'),

                        )
                        ),
                        Expanded(child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(width: 1.0),
                              textStyle: const TextStyle(fontSize: 25)),
                          onPressed: _clearControllers,
                          child: Text(curr_runrate.toStringAsFixed(1).toString()),
                        )
                        ),
                      ],
                    ),),
                    Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(width: 1.0),
                              textStyle: const TextStyle(fontSize: 25)),
                          onPressed: _decCurrentOver,
                          child: Text('Overs'),

                        )
                        ),
                        Expanded(child: TextButton(
                          /*style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                //textStyle: TextStyle(fontSize: 30),
                              ),*/
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(width: 1.0),
                              textStyle: const TextStyle(fontSize: 25)),
                          //onPressed: _clearControllers,
                          onPressed: _incCurrentOver,
                          child: Text(_curr_over.toString()),
                        )
                        ),
                      ],
                    ),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: checkBoxVisValueMaster,
                      onChanged: (bool? BoolVal) {
                        setState(() {
                          checkBoxVisValueMaster = BoolVal!;
                        });
                      },
                    ),
                  Visibility(
                    visible: checkBoxVisValueMaster,
                      child: Checkbox(
                        value: checkBoxVisValue,
                        onChanged: (bool? BoolVal) {
                          setState(() {
                            checkBoxVisValue = BoolVal!;
                          });
                        },
                      ),
                  ),

                  Visibility(
                      visible: checkBoxVisValueMaster,
                      child: Text('2nd Inning')),


                    Visibility(
                      visible: checkBoxVisValueMaster,
                      child:  TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: _clearTeams,
                      child: Text('Reset Teams'),
                    ),),
                    Visibility(
                      visible: checkBoxVisValueMaster,
                      child:  TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: _clearControllers,
                        child: Text('Reset Names'),
                      ),),
                    Visibility(
                      visible: checkBoxVisValueMaster,
                      child:  TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: _clearRunrateandOversControllers,
                        child: Text('Clear Runrate and Overs'),
                      ),),

                    Visibility(
                        visible: checkBoxVisValueMaster,
                        child: SizedBox(width:70, child: TextField(
                      textAlign: TextAlign.center,
                      controller: TotalScoreController,
                      decoration: InputDecoration(
                        hintText: 'Total Score', ),
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    ),),

                    Visibility(
                      visible: checkBoxVisValueMaster,
                      child: SizedBox(width:70, child: TextField(
                      textAlign: TextAlign.center,
                      //initialValue: '300', //
                      controller: TotalOversController,
                      decoration: InputDecoration(
                        hintText: 'Total Overs', ),
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    ),),

                    //MyBlinkingButton(),

                  ],
                ),

                //const Text('You have pushed the button this many times:',),
                //Text(
                // '$_counter1',
                // style: Theme.of(context).textTheme.headline4,
                //),
              ],

            ),
            /*  const Text('You have pushed the button this many times:',),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
*/
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _resetCounters,
        tooltip: 'Increment',
        child: const Icon(Icons.lock_reset),
      ), */
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
