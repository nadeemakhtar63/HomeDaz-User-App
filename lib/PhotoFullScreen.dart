import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoShow extends StatefulWidget {
  final imageFile;
  const PhotoShow({Key? key,required this.imageFile}) : super(key: key);

  @override
  State<PhotoShow> createState() => _PhotoShowState();
}

class _PhotoShowState extends State<PhotoShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(widget.imageFile)
        )
     )
    );
  }
}
