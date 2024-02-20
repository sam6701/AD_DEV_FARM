import 'package:adifoodapp/helper/helper_function.dart';
import 'package:adifoodapp/screen/detail_page.dart';
import 'package:adifoodapp/services/database_service.dart';
import 'widget/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  String foodname = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text(
          "Search",
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search groups....",
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    initiateSearchMethod();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Colors.green),
                )
              : groupList(),
        ],
      ),
    );
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
        foodname = searchController.text;
      });
      await DatabaseService()
          .searchByName(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  groupList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                  foodname,
                  searchSnapshot!.docs[index]['image'],
                  searchSnapshot!.docs[index]['categories'],
                  searchSnapshot!.docs[index]['price'],
                  searchSnapshot!.docs[index]['description'],
                  searchSnapshot!.docs[index]['id']);
            },
          )
        : Container();
  }

  Widget groupTile(String foodname, String image, String categories, int price,
      String description, String id) {
    // function to check whether user already exists in group

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: Container(
        //margin: EdgeInsets.only(left: 20),
        height: 100,
        width: 50,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      title: Text(
        foodname,
        style:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
      ),
      subtitle: Text("categories: ${categories}"),
      trailing: InkWell(
        onTap: () {
          nextScreen(
              context,
              DetailPage(
                  image: image,
                  name: foodname,
                  price: price,
                  description: description,
                  categories: categories,
                  id: id));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
            border: Border.all(color: Colors.white, width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Text(
            "view",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
