import 'package:flutter/cupertino.dart';
import 'package:shop_app_bloc/localiziation/app_localization.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context).getTranslatedValues(key);
}
