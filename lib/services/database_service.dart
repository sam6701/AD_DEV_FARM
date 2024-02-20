import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference foodCollection =
      FirebaseFirestore.instance.collection("food");
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "cart": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  Future savingUserDataInCart(String productId, int no) async {
    Map m = {'id': productId, 'quantity': no};
    return await userCollection.doc(uid).update({
      "cart": FieldValue.arrayUnion([m]),
    });
  }

  Future deletingUserDataInCart(String productId, int no) async {
    Map m = {'id': productId, 'quantity': no};
    print('harsh: delete $m');
    return await userCollection.doc(uid).update({
      "cart": FieldValue.arrayRemove([m]),
    });
  }

  // Future deletingUserDataInCart(String productId, int no) async {
  //   Map m = {'id': productId, 'quantity': no};
  //   return await userCollection.doc(uid).update({
  //     // "fullName": fullName,
  //     // "email": email,
  //     "cart": FieldValue.arrayRemove([m]),
  //     // "profilePic": "",
  //     // "uid": uid,
  //   });
  // }

  Future getProductDetail(String id) async {
    // return (await foodCollection.where("id", isEqualTo: id).get()).docs[0];
    return (await foodCollection.doc(id).get()).data();
  }

  Future getMyCartDetail() async {
    return (await userCollection.doc(uid).get())['cart'];
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // search
  searchByName(String groupName) {
    return foodCollection.where("foodname", isEqualTo: groupName).get();
  }

  AllFood() async {
    return foodCollection.get();
  }
}
