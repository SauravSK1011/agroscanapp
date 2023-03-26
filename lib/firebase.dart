import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firebaseefunc {
  static adduser(String name, String cnumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    final docs = FirebaseFirestore.instance.collection('Users');
    final json = {
      'Name': name,
      'Contact Number': cnumber,
      'uid': uid,
    };
    print("Added");
    await docs.add(json);
  }

  static String whatuid() {
    FirebaseAuth auth = FirebaseAuth.instance;

    String uid = auth.currentUser!.uid.toString();
    return uid;
  }

  static List<Myusers> transactions = [];
  static Future<Myusers> getdata() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .get()
        .then((snapshort) => snapshort.docs.forEach((element) {
              var transactionsinfo = element.data() as Map<String, dynamic>;

              // String myuid = whatuid();

              // if (myuid == transactionsinfo["uid"]) {
              transactions.add(Myusers(
                  name: transactionsinfo["Name"] ?? "",
                  cnumber: transactionsinfo["Contact Number"] ?? "",
                  uid: transactionsinfo["uid"] ?? ""));
              // }
            }))
        .catchError((err) => print("err is" + err.toString()));
    print("transactions.length.toString()");
    print(transactions.length.toString());
    String myuid = whatuid();
late Myusers myuser;
    for (var i = 0; i < transactions.length; i++) {
      if (myuid == transactions[i].uid) {
         myuser = Myusers(
            name: transactions[i].name,
            cnumber: transactions[i].cnumber,
            uid: transactions[i].uid);
      }

    }
              print("myuser.name");              print(myuser.name);


    // print(transactions.length);
    // setState(() {
    //   load = true;
    // });
    return myuser;
  }
}

class Myusers {
  final String name;
  final String cnumber;

  final String uid;
  Myusers({
    required this.name,
    required this.cnumber,
    required this.uid,
  });
}
