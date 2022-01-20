import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselContainer extends StatelessWidget {
  final String imageUrl, id;
  CarouselContainer(this.imageUrl, this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.blue[100],
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(1, 2))
          ],
          border: Border.all(color: Colors.black38, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            filterQuality: FilterQuality.high,
            loadingBuilder: (context, widget, event) {
              if (event != null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return widget;
              }
            },
          ),
          Text(
            "#" + id,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class CarouselContainerLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ),
    );
  }
}
