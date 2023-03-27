import 'package:flutter/material.dart';

class ConuntriesCodeScreen extends StatelessWidget {
  const ConuntriesCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          "Countries",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  
                },
                child: Column(
                  children: [
                    ListTile(
                      trailing: Text('91',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          )),
                      title: Text(
                        'India',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.1,
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
