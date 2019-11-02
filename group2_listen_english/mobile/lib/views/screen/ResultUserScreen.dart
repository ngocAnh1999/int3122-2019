import 'package:flutter/material.dart';

class ResultUserScreen extends StatefulWidget {
  @override
  _ResultUserState createState() => _ResultUserState();
}

class _ResultUserState extends State<ResultUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User Result Study"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 160.0,
                child: Card(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(50.0),
                        child: Image.network(
                          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/cq5dam-web-1200-675-1552905198.jpeg?crop=0.5625xw:1xh;center,top&resize=980:*',
                          fit: BoxFit.fill,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Mother of Dragons",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.blue,
                  size: 32.0,
                ),
                title: Text("Sách đã học",
                    style: TextStyle(fontWeight: FontWeight.w400)),
                subtitle: Text("Số lượng sách hoàn thành trên 80%"),
                trailing: Text(
                  "100/169",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.grey,
                indent: 16,
              ),
              ListTile(
                leading: Icon(
                  Icons.sort_by_alpha,
                  color: Colors.blue,
                  size: 32.0,
                ),
                title: Text("Số từ mới đã học",
                    style: TextStyle(fontWeight: FontWeight.w400)),
                subtitle: Text("Số lượng từ mới được học thêm"),
                trailing: Text(
                  "1024",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.grey,
                indent: 16,
              ),
              ListTile(
                leading: Icon(
                  Icons.mic_none,
                  color: Colors.blue,
                  size: 32.0,
                ),
                title: Text("Đánh giá phát âm",
                    style: TextStyle(fontWeight: FontWeight.w400)),
                subtitle: Text("So với phát âm người bản ngữ"),
                trailing: Text(
                  "Good",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.grey,
                indent: 16,
              ),
            ],
          ),
        ));
  }
}
