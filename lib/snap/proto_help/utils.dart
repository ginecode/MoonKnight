import 'dart:convert';
import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:protobuf/protobuf.dart';
import 'package:moonknight/models/lib/chat.pbenum.dart';

extension ProtoParse on GeneratedMessage {
  Map<String, dynamic>? toMap() {
    try {
      return (json.decode(json.encode(toProto3Json())) as Map<String, dynamic>);
    } catch (e) {
      dev.log('Protobuf parsing error');
    }
    return null;
  }

  String stringify() {
    return toMap().toString();
  }

  void log() {
    dev.log(stringify());
  }
}

T? fromQuerySnap<T extends GeneratedMessage>(T obj, QueryDocumentSnapshot<Map<String, dynamic>> q) {
  if (!q.exists) return null;
  obj.log();
  obj.mergeFromProto3Json(q.data(), ignoreUnknownFields: true);
  obj.mergeFromProto3Json({Const.id.name: q.id}, ignoreUnknownFields: true);
  obj.log();

  return obj;
}

T? fromDocSnap<T extends GeneratedMessage>(T obj, DocumentSnapshot<Map<String, dynamic>> doc) {
  if (!doc.exists || doc.data() == null) return null;
  obj.log();
  obj.mergeFromProto3Json(doc.data(), ignoreUnknownFields: true);
  obj.mergeFromProto3Json({Const.id.name: doc.id}, ignoreUnknownFields: true);
  obj.log();

  return obj;
}

T fromMap<T extends GeneratedMessage>(T obj, Map<String, dynamic> map) {
  obj.log();
  obj.mergeFromProto3Json(map, ignoreUnknownFields: true);
  obj.log();

  return obj;
}
