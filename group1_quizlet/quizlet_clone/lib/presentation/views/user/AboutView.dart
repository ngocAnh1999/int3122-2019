import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  final List<dynamic> developers = [
    {
      'name': 'Hà Tuấn Phong',
      'email': 'phonghatuan1998@gmail.com',
    },
    {'name': 'Phí Văn Minh', 'email': 'phivanminh10@gmail.com'}
  ];
  final String productName = 'Quizlet Clone';
  final String techStack = 'Flutter, Firebase';

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    final TextStyle subtitleStyle = TextStyle(fontSize: 14);
    return Scaffold(
      appBar: AppBar(title: Text('Thông tin sản phẩm')),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Tên sản phẩm', style: titleStyle),
              subtitle: Text(productName, style: subtitleStyle),
            ),
            ListTile(
              title: Text('Phát triển bởi', style: titleStyle),
              subtitle: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffFFD69E)),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text('${developers[0]['name']}'),
                    subtitle: Text('${developers[0]['email']}'),
                  ),
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF56CC77)),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text('${developers[1]['name']}'),
                    subtitle: Text('${developers[1]['email']}'),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text('Công nghệ sử dụng', style: titleStyle),
              subtitle: Text(techStack, style: subtitleStyle),
            )
          ],
        ),
      ),
    );
  }
}
