import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/constant/firebase_const.dart';

final firebaseServiceProvider = Provider((ref) => FirebaseService());
