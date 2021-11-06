import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void addToOrders(double orderprice) {


  DateTime now = new DateTime.now();
  DateTime date =
      new DateTime(now.year, now.month, now.day, now.hour, now.minute);

  String? mine = date.toString();
  String? tester = DateFormat('yyMMddhhmmssS').format(date).toString();


  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Cart')
      .get()
      .then((snapshots) => {
            snapshots.docs.forEach((productid) {
              FirebaseFirestore.instance
                  .collection('Orders')
                  .doc(uid)
                  .set({
                'uid' : uid,
                'url': productid.get("url"),
                'name': productid.get("name"),
                'description': productid.get("description"),
                'category': productid.get('category'),
                'unit price': productid.get("price"),
                'total': productid.get("total"),
                'date': date,
                'quantity': productid.get("quantity")
              });
            })
          });

  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Cart')
      .get()
      .then((snapshots) => {
    snapshots.docs.forEach((productid) {
      FirebaseFirestore.instance
          .collection('TestOrders')
          .doc(uid).collection('Orders').doc(mine).collection('products').doc(productid.id)
          .set({
        'uid' : uid,
        'url': productid.get("url"),
        'name': productid.get("name"),
        'description': productid.get("description"),
        'category': productid.get('category'),
        'unit price': productid.get("price"),
        'total': productid.get("total"),
        'date': date,
        'quantity': productid.get("quantity")
      });

    })
  });
  FirebaseFirestore.instance.collection('TestOrders').doc(uid).collection('Orders')
      .doc(mine)
      .set({
    'orderid' : tester,
    'orderprice' : orderprice,
  });

}