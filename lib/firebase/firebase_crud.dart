import 'package:monitoring_cctv/models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Cctv');

class FirebaseCRUD {
  //CREATE FUNCTION
  static Future<Response> addCctv(
      {required String cctvname,
      required String cctvip,
      required String cctvlocation,
      String? cctvstatus,
      String? cctvlat,
      String? cctvlong}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "cctv_name": cctvname,
      "cctv_ip": cctvip,
      "cctv_location": cctvlocation,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully Added";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  //READ FUNCTION
  static Stream<QuerySnapshot> readCctv() {
    CollectionReference notesItemCollection = _Collection;
    return notesItemCollection.snapshots();
  }

  //UPDATE FUNCTION
  static Future<Response> updateCctv(
      {required String cctvname,
      required String cctvip,
      required String cctvlocation,
      String? cctvstatus,
      String? cctvlat,
      String? cctvlong,
      String? docid}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docid);

    Map<String, dynamic> data = <String, dynamic>{
      "cctv_name": cctvname,
      "cctv_ip": cctvip,
      "cctv_location": cctvlocation
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Update";
    }).catchError((e) {
      response.code = 500;
      response.message = e();
    });
    return response;
  }

  //DELETE FUNCTION
  static Future<Response> deleteCctv({
    required docid,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docid);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Delete";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }
}
