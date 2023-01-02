import 'package:flutter/material.dart';
import 'package:calendar_schedular/const/colors.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // true - 시간, false - 내용
  final bool isTime;

  final FormFieldSetter<String>? onSaved;

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTime) renderTextField(),
        if (!isTime)
          Expanded(
            child: renderTextField(),
          ),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      // null이 return 되면 에러가 없다
      // 에러가 있으면 에러가 String으로 return 된다.
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '값을 입력해주세요.';
        }

        if (isTime) {
          int time = int.parse(value);
          if (time < 0) {
            return '0 이상의 숫자를 입력해주세요';
          }
          if (time > 24) {
            return '24 이하의 숫자를 입력해주세요';
          }
        } else {
          if (value.length > 500) {
            return '500자 이하의 글자를 입력해주세요.';
          }
        }

        return null;
      },
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      maxLength: 500,
      onSaved: onSaved,
      inputFormatters: isTime
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      maxLines: isTime ? 1 : null,
      expands: !isTime,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
