import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/features/chat/ui/chat_view_model.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_data.dart';
import '../../../setup/test_helpers.dart';

void main() {
  group("ChatViewModel - ", () {
    ChatViewModel getModel() => ChatViewModel();

    setUpAll(() async => await registerSharedServices());

    test("when setMessage called with message, then message is set", () {
      // Arrange - Setup

      final model = getModel();

      // Act

      const message = "moment by moment forget yourself.";

      model.setMessage(message);

      // Assert - Result

      var actual = model.message;

      expect(actual, message);
    });

    test("when uploadImageToFirebase called, then image uplaoded to firebase and imageUrl set", () async {
      // Arrange - Setup
      getAndRegisterFirebaseService(
        email: testUser.email,
        password: testUser.password,
      );

      final model = getModel();

      // Act

      await model.uploadImageToFirebase();

      // Assert

      var actual = model.imageUrl;

      var expected = await testReference.getDownloadURL();

      expect(actual, expected);
    });

    test("when sendMessage called, then message is sent", () async {
      // Arrange - Setup

      registerFallbackValue(testUser);

      getAndRegisterChatService();

      final model = getModel();

      // Act

      const message = "moment by moment forget yourself.";

      model.setMessage(message);

      await model.sendMessage(testUser);

      // Assert - Result

      // verify(() async => await model.sendMessage(testUser)).called(1);
      // verify(() async => await model.uploadImageToFirebase()).called(1);
    });

    test("when deleteMessage called, then message is deleted", () async {
      // Arrange - Setup

      getAndRegisterChatService();
      final model = getModel();

      // Act

      await model.deleteMessage(testMessage);

      // Assert - Result

      verify(() => chatService.deleteMessage(testMessage.textID, CollectionPath.chat.path)).called(1);
    });

    // TODO: finish writing test

    // test("when deleteMessageImage called with a message with an image, then the image is deleted", () async {
    //   // Arrange - Setup

    //   // TestWidgetsFlutterBinding.ensureInitialized();
    //   // await Firebase.initializeApp();

    //   getAndRegisterFirebaseService(
    //     email: testUser.email,
    //     password: testUser.password,
    //   );
    //   final model = getModel();

    //   // Act

    //   await model.deleteMessageImage(testMessageWithImage);

    //   // Assert - Result
    // });
  });
}
