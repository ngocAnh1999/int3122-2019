import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final String descriptionAbout =
      "Ứng dụng giúp học sinh học nói tiếng Anh dựa trên công nghệ nhận dạng giọng nói. Tập hội thoại được lấy từ bộ sách giáo khoa Tiếng Anh của Nhà xuất bản giáo dục Việt Nam";

  @override
  initState() {
    super.initState();
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About us"),
        ),
        body: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 160,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        child: Text("Giới thiệu",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600)),
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Padding(
                          child: Text(descriptionAbout,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400)),
                          padding: EdgeInsets.all(10.0))
                    ],
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text("https://sachmem.vn"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("lienhe@sachmem.vn"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.phone_iphone),
                      title: Text("+842435122222"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.face),
                      title: Text("Facebook"),
                      onTap: () {},
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Phiên bản",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600)),
                    ),
                    ListTile(
                      title: Text(
                        "Phiên bản 1.0 - 10/2019",
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
