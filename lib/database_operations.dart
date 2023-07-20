import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  Future updateSpeedLimit(int speed) async {
    try {
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference ref = database.ref();
      await ref.update(
        {
          "SPEED LIMIT": speed,
        },
      );
    } catch (e) {
      return 1;
    }
  }

  Future<int> fetchSpeedLimit() async {
    try {
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference ref = database.ref();

      DatabaseEvent databaseEvent = await ref.once();
      Map map = databaseEvent.snapshot.value as Map;

      return map['SPEED LIMIT'];
    } catch (e) {
      return 0000;
    }
  }

  Future<String> fetchEngineStatus() async {
    try {
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference ref = database.ref();

      DatabaseEvent databaseEvent = await ref.once();
      Map map = databaseEvent.snapshot.value as Map;

      return map['MSG'];
    } catch (e) {
      return '0';
    }
  }

  Future turnOn() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref();
    await ref.update(
      {
        "MSG": "1",
      },
    );
  }

  Future turnOff() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref();
    await ref.update(
      {
        "MSG": "0",
      },
    );
  }

  Future updateProfile(String name, String phoneNum, String email) async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref();
    await ref.update(
      {
        "NAME": name,
        "PHONE NUM": phoneNum,
        "EMAIL": email,
      },
    );
  }

  Future<Map> fetchProfile() async {
    Map map = {};
    try {
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference ref = database.ref();

      DatabaseEvent databaseEvent = await ref.once();
      map = databaseEvent.snapshot.value as Map;

      return map;
    } catch (e) {
      return map;
    }
  }
}
