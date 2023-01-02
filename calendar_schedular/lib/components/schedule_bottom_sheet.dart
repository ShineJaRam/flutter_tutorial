import 'package:calendar_schedular/components/custom_text_field.dart';
import 'package:calendar_schedular/const/colors.dart';
import 'package:calendar_schedular/model/category_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_schedular/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? contents;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 16.0,
              ),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (String? value) {
                        startTime = int.parse(value!);
                      },
                      onEndSaved: (String? value) {
                        endTime = int.parse(value!);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    _Contents(
                      onSaved: (String? value) {
                        contents = value;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    FutureBuilder<List<CategoryColor>>(
                        future: GetIt.I<LocalDatabase>().getCategoryColors(),
                        builder: (context, snapshot) {
                          return _ColorPicker(
                            colors: snapshot.hasData
                                ? snapshot.data!
                                    .map(
                                      (e) => Color(
                                        int.parse('FF${e.hexCode}', radix: 16),
                                      ),
                                    )
                                    .toList()
                                : [],
                          );
                        }),
                    const SizedBox(height: 8.0),
                    _SaveButton(
                      onPressed: onSavePressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    // formKey는 생성을 했는데,
    // formWidget과 결합을 안했을 때
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      print('에러가 없습니다.');
      formKey.currentState!.save();

      print('---------');
      print('startTime, $startTime');
      print('endTime, $endTime');
      print('contents, $contents');
    } else {
      print('에러가 있습니다.');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String>? onStartSaved;
  final FormFieldSetter<String>? onEndSaved;

  const _Time({
    required this.onStartSaved,
    required this.onEndSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: '시작 시간',
            isTime: true,
            onSaved: onStartSaved,
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: CustomTextField(
            label: '마감 시간',
            isTime: true,
            onSaved: onEndSaved,
          ),
        ),
      ],
    );
  }
}

class _Contents extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;

  const _Contents({
    required this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  final List<Color> colors;

  const _ColorPicker({
    required this.colors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10,
      children: colors
          .map(
            (e) => renderColor(e),
          )
          .toList(),
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            onPressed: onPressed,
            child: const Text('저장'),
          ),
        ),
      ],
    );
  }
}
