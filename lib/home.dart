import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:idea_generator/api_services.dart';
import 'package:idea_generator/idea_model.dart';
import 'package:jumping_dot/jumping_dot.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool enabled = false;
  Future<dynamic> _ideaFuture = Future<dynamic>.value(null);

  @override
  initState() {
    super.initState();
  }

  void _getData() async {
    setState(() {
      _ideaFuture = ApiService().getIdea();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Welcome to the idea Generator",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Bored? Click the Button Below to get started with super fun ideas ",
                      style: TextStyle(color: Colors.white, fontSize: 6),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ShakeAnimatedWidget(
                  enabled: enabled,
                  duration: const Duration(milliseconds: 2000),
                  shakeAngle: Rotation.deg(z: 90),
                  curve: Curves.linear,
                  child: const Image(
                    image: AssetImage('assets/light-bulb.png'),
                  )),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: FutureBuilder<dynamic>(
                      future: _ideaFuture,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting){
                          return JumpingDots(
                            color: Colors.white,
                            radius: 10,
                            numberOfDots: 6,
                            animationDuration: Duration(microseconds: 70000),
                          );
                        }
                        if (snapshot.hasData) {
                          dynamic data = snapshot.data;
                          String message = "";
                          if (data is Idea) {
                            Idea idea = data;
                            message = idea.activity;
                          } else {
                            message = data.toString();
                          }
                          return Center(
                            child: Text(
                              message,
                              style: const TextStyle(color: Colors.white,fontSize: 20),
                            ),
                          );
                        }
                        return const Center(
                            child: Text("",
                                style: TextStyle(color: Colors.white)));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        enabled = !enabled;
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            enabled = !enabled;
                          });
                        });
                        _getData();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue, // Text color
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Generate Idea",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ));
  }
}
