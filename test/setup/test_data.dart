import 'package:chatapp/shared/models/user.dart' as abs;
import 'package:chatapp/shared/models/user_model.dart';

import 'test_mocks.dart';

const abs.User testUser = UserModel(
  id: '1101',
  email: 'baki@grappler.io',
  password: 'Password11!!',
  username: 'baki',
  url: 'profile-image.bucket.firebase',
);

final mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

final mockFirebaseUser = MockFirebaseUser();
