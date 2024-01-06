import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GridTest extends StatelessWidget {
  //final List<Subject> subjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: .85,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    //color: Colors.grey.withOpacity(0.5),
                    color: const Color(0xff002147).withOpacity(0.5),
                    width: 1,
                  ),
                ),
                elevation: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/subject_icon/book.svg",
                      height: 50,
                      width: 50,
                      color: const Color(0xff002147),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Bangla 2nd Paper $index",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
