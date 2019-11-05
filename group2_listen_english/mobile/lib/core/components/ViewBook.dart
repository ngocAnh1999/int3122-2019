import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/components/GetRatings.dart';
import 'package:mobile/core/constant/Constant.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/views/widgets/UnitList.dart';

class ViewBook extends StatelessWidget {
  final Book item;

  const ViewBook({@required this.item});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => GridItemDetails(this.item),
            builder: (context) => UnitList(book: item),
          ),
        );
      },
      child: Card(
        elevation: 1.0,
        margin: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 10.0 / 12.0,
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  imageUrl: URL_IMG + this.item.image,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFD73C29),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 0.0),
                  GetRatings(),
                  SizedBox(height: 2.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderContent extends StatelessWidget {
  final Book item;

  HeaderContent(this.item);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFD73C29),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 9.0,
                    ),
                  ),
                  GetRatings(),
                  MovieDesc(this.item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDesc extends StatelessWidget {
  final Book item;

  MovieDesc(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  'RELEASE DATE:',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   item.releaseDate,
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 9.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'RUNTIME:',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   item.runtime,
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 9.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
