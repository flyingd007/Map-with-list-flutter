import 'package:Assignment01/models/job.dart';
import 'package:Assignment01/screens/mapScreen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  final List<Job> list;
  HomeScreen({@required this.list});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void delete(int x) {
    setState(() {
      widget.list.removeAt(x);
    });
  }

  void share(int index) {
    final RenderBox box = context.findRenderObject();
    final String text = widget.list[index].description;
    print("object");
    Share.share(text,
        subject: widget.list[index].company,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List view"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Slidable(
            child: Container(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(MapScreen.mapRoute);
                },
                child: ListTile(
                  title: Text((widget.list[index].company).toString()),
                ),
              ),
            ),
            actionExtentRatio: 0.25,
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: [
              IconSlideAction(
                caption: "Share",
                color: Colors.blue,
                onTap: () => share(index),
                icon: Icons.share,
              ),
              IconSlideAction(
                caption: "Delete",
                color: Colors.red,
                onTap: () => delete(index),
                icon: Icons.delete,
              ),
            ],
          );
        },
        itemCount: widget.list.length,
      ),
    );
  }
}
