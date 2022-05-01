// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../config/themes/colors.dart';
import '../config/themes/theme.dart';


SnackBar snackBar({String? content}) => SnackBar(
      content: Text(
        content!,
        style: AppTheme.titleStyle
            .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      backgroundColor: AppColor.orange.withOpacity(.90),
      duration: const Duration(seconds: 1),
    );
