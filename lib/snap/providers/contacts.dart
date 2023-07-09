// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';

part 'contacts.g.dart';

class PhoneContact {
  String name;
  String phone;

  PhoneContact({
    required this.name,
    required this.phone,
  });
}

@riverpod
FutureOr<List<PhoneContact>> phoneContact(PhoneContactRef ref) async {
  lava((await Permission.contacts.status));

  // if (await Permission.contacts.status == PermissionStatus.denied) {
  //   await Permission.contacts.request();
  // }

  if (await Permission.contacts.isPermanentlyDenied) {
    // The user opted to never again see the permission request dialog for this
    // app. The only way to change the permission's status now is to let the
    // user manually enable it in the system settings.
    lava('obj');
    openAppSettings();
  }

  if (await FlutterContacts.requestPermission()) {
    // Get all contacts (lightly fetched)
    List<Contact> contacts = await FlutterContacts.getContacts(
      // withThumbnail: true,
      withProperties: true,
    );
    lava(contacts.toString());

    return contacts
        .where(
          (e) => e.phones.isNotEmpty && (e.phones[0].normalizedNumber.isNotEmpty || e.phones[0].number.isNotEmpty),
        )
        .map(
          (e) => PhoneContact(
            name: e.displayName,
            phone: e.phones[0].normalizedNumber + e.phones[0].number,
          ),
        )
        .toList();
  }
  return [];
}
