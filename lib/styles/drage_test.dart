import 'package:flutter/material.dart';

class DragTest extends StatefulWidget {
  const DragTest({Key key}) : super(key: key);

  @override
  State<DragTest> createState() => _DragTestState();
}

class _DragTestState extends State<DragTest> {
  bool drag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: drag?Icon(Icons.delete):Container(),
      ),
      body: Center(child: Draggable(
        onDragStarted: (){
          setState(() {
            drag = true;
          });
        },
       childWhenDragging: Icon(Icons.eighteen_mp),
        feedback: Container(
          height: 150,
          width: 150,
           color: Colors.amber,
        ),
        child: Container(
          height: 150,
          width: 150,
          color: Colors.amber,
        ),
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            drag = true;
          });

        },

        child: Icon(Icons.add),
      ),
    );
  }
}
