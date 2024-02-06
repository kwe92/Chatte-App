import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/features/chat/ui/chat_view_model.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:chatapp/app/utils/validator.dart';
import 'package:chatapp/shared/widgets/circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendMessage extends StatelessWidget {
  final User user;

  const SendMessage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final ChatViewModel model = context.read<ChatViewModel>();

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (context.watch<ChatViewModel>().pickedImage != null) ...[
                Image(
                  image: FileImage(model.pickedImage!),
                ),
                CircleWidget(
                  size: 40,
                  backgroundColor: Colors.transparent,
                  borderWidth: 2,
                  borderColor: AppColor.primaryThemeColor,
                  child: IconButton(
                    onPressed: () => model.clearImageData(),
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: AppColor.primaryThemeColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
          Row(
            children: [
              //Typing field
              Expanded(
                child: Form(
                  key: model.formKey,
                  child: TextFormField(
                    controller: model.messageController,
                    onChanged: model.setMessage,
                    // Validators
                    validator: _messageValidator,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Type a message here...",
                      prefixIcon: IconButton(
                        onPressed: () => model.pickImage(user),
                        icon: const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Validator.trySubmit(model.formKey) ? model.sendMessage(user) : null,
                icon: const CircleWidget(
                  size: 42,
                  backgroundColor: AppColor.primaryThemeColor,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String? _messageValidator(String? value) {
  if (value!.trim().isEmpty) {
    return "can not be empty";
  }
  if (value.length > 150) {
    return "less than 150 characters required";
  }
  return null;
}
