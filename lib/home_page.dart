import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(children: [
          Positioned(
              child: Container(
            width: double.maxFinite,
            height: 400,
            decoration: const BoxDecoration(
                image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage("assets/logo1.png"),
            )),
          )),
          Positioned(
              top: 350,
              child: Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // print("Student logIn");
                      },
                      child: Container(
                        height: 80,
                        width: 350,
                        child: const Center(
                            child: Text(
                          "Student LogIn",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                        decoration: BoxDecoration(
                            color: const Color(0xff002147),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.blue,
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(4, 4))
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        // print("Parents logIn");
                      },
                      child: Container(
                        height: 80,
                        width: 350,
                        child: const Center(
                            child: Text(
                          "Parents LogIn",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                        decoration: BoxDecoration(
                            color: const Color(0xff002147),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.blue,
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(4, 4))
                            ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          foregroundColor: Colors.blue.shade900),
                      onPressed: () {
                        // print("Mahmuni Anglo Pali High School");
                      },
                      child: const Text('About Us'),
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
