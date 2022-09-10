import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "")
            ? FirebaseFirestore.instance
                .collection('searchItems')
                .where("searchKeywords", arrayContains: name)
                .snapshots()
            : FirebaseFirestore.instance.collection("searchItems").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.only(top: 16),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(data['name'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            leading: CircleAvatar(
                              child: Image.network(
                                data['imageUrl'],
                                width: 100,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                              radius: 40,
                              backgroundColor: Colors.lightBlue,
                            ),
                            trailing: Icon(
                              Icons.shopping_basket,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
