import 'dart:math';
import 'package:flutter/material.dart';
import '../widget/football.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> footBallAnimation;
  AnimationController footBallController;
  Animation<double> footBallCircle;
  Animation<double> legAnimation;
  AnimationController legController;
  Animation<double> footAnimation;
  Animatable<double> footController;

  void initState() { 
    super.initState();
    footBallController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    footBallAnimation = Tween<double>(begin: -30.0, end: -170.0).animate(
      CurvedAnimation(
        parent: footBallController,
        curve: Curves.easeIn,
      )
    );

     legController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    legAnimation = Tween(begin: 0, end: 3.14).animate(
      CurvedAnimation(
        parent: legController,
        curve: Curves.linear,
      )
    );
    
    legAnimation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        legController.repeat();

      }
    });
    legController.forward();

   

    // footCircle = Tween<double>(begin: 0, end: 2*pi).animate(
    //   CurvedAnimation(
    //     parent: footController,
    //     curve: Curves.elasticOut,
    //   )
    // );

    
  }

  onTap(){
     if(footBallController.status == AnimationStatus.completed){
       footBallController.reverse();
    //  }else if(footController.status == AnimationStatus.forward){
    //    footController.reverse();
    //  }else if(footController.status == AnimationStatus.reverse){
    //    footController.forward();
     }else if(footBallController.status == AnimationStatus.dismissed){
       footBallController.forward();
     }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              builtBallAnimation(),
              footbox(),
              foot(),
              buildLeftFoot(),
            ],
          ),
        ),
        
        onTap: onTap,
      ),
    );
  }

  Widget builtBallAnimation(){
    return AnimatedBuilder(
      animation: footBallAnimation, 
      builder: (BuildContext context, Widget child) {
        return Positioned(
          child: child,
          top: footBallAnimation.value,
          right: 14.0,
          left: 14.0,
        );
      },
      child: Football(),
    );

  // return AnimatedBuilder(
  //     animation: footCircle,
  //     builder: (BuildContext context, Widget child) {
  //       return Transform.rotate(
  //         angle: footCircle.value,
  //         child: child,
  //       );
  //     },
  //     child: Football(),
  //   );

  }

  Widget buildLeftFoot(){
    return Positioned(
      left: 2.0,
      child: AnimatedBuilder(
      animation: legAnimation,
      child: Container(
          width: 15.0,
          height: 125,
          color: Colors.brown,
      ),
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          child: child,
          angle: (pi/3) * 0.5,
          alignment: Alignment.topLeft,
        );
      },
      ),
    );
  }

  Widget footbox(){
    return Container(
      height: 180.0,
      width: 180.0,
      color: Colors.brown,
    );
  }

  Widget foot(){
    return Positioned(
      right:225.0,
      top: 95,
      child: Container(
        width: 50.0,
        height: 30.0,
        color: Colors.black87,
      ),
    );
  }
}