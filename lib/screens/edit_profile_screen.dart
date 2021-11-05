import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/localiziation/localizatrion_constant.dart';
import 'package:shop_app_bloc/screens/map_screen.dart';

import '/bloc/cuibts/auth_cuibt.dart';
import '/bloc/states/auth_state.dart';
import '/shared/component.dart';

class EditProfileScreen extends StatelessWidget {
  var _emailController = TextEditingController();
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _mapController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // var _emailController = TextEditingController();

  void _edit(
    context, {
    required String email,
    required String username,
    required String phone,
  }) async {
    if (_formKey.currentState!.validate()) {
      await AuthCuibt.get(context).editProfileData({
        'phone': phone,
        'name': username,
        'email': email,
      }).then((value) => _formKey.currentState!.save());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCuibt, AppAuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        final _profileData = AuthCuibt.get(context).profileModel;
        _emailController.text = _profileData!.data!.email!;
        _nameController.text = _profileData.data!.name!;
        _phoneController.text = _profileData.data!.phone!;
        if (state is GetProfileLoadingState || _profileData == null) {
          return buildProgressIndicator();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(getTranslated(context, 'edit_profile_heading'),
                style: TextStyle(color: Colors.black)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: CustomPaint(
                          painter: LinearPainter(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.amber),
                          child: ClipOval(
                            child: Stack(
                              children: [
                                Image(
                                  image:
                                      NetworkImage(_profileData.data!.image!),
                                ),
                                Positioned(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.camera_alt_rounded),
                                    onPressed: () {},
                                  ),
                                  bottom: 15,
                                  right: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextFiled(
                          controller: _nameController,
                          hintText:
                              getTranslated(context, 'username_hint_text'),
                          preixIcon: Icon(Icons.supervised_user_circle),
                          validatorFunction: (String? val) {
                            if (val!.length < 4) {
                              return getTranslated(
                                  context, 'username_error_text');
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFiled(
                          controller: _emailController,
                          hintText: getTranslated(context, 'e-mail_hint_text'),
                          preixIcon: Icon(Icons.email),
                          validatorFunction: (val) {
                            if (!val!.contains('@')) {
                              return getTranslated(
                                  context, 'e-mail_error_text');
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFiled(
                          controller: _phoneController,
                          hintText: getTranslated(context, 'phone_hint_text'),
                          preixIcon: Icon(Icons.phone_android),
                          validatorFunction: (String? val) {
                            if (val!.length < 6) {
                              return getTranslated(context, 'phone_error_text');
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFiled(
                          controller: _mapController,
                          hintText: getTranslated(context, 'address_hint_text'),
                          preixIcon: Icon(Icons.place),
                          validatorFunction: (String? val) {
                            if (val!.length < 6) {
                              return getTranslated(
                                  context, 'address_error_text');
                            }
                            return null;
                          },
                          keyboardType: TextInputType.streetAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildButton(
                          context,
                          function: () => navTo(
                            context,
                            MapScreen(),
                          ),
                          child: buildButtonText(
                              text: getTranslated(context, 'edit_profile_map')),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildButton(
                          context,
                          function: () => _edit(
                            context,
                            email: _emailController.text,
                            username: _nameController.text,
                            phone: _phoneController.text,
                          ),
                          child: (state is EditProfileLoadingState)
                              ? buildProgressIndicator(isMainColor: false)
                              : buildButtonText(
                                  text: getTranslated(
                                      context, 'edit_profile_button_text'),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LinearPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      // ..strokeWidth = 4.0
      ..color = Colors.redAccent;
//      canvas.drawOval(
//       Rect.fromLTWH(size.width - 120, 40, 100, 100),
//       paint,
//     );
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width * 3 / 7, size.height * 0.6);
    path.lineTo(size.width, size.height * 0.6 / 6);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LinearPainter oldDelegate) => false;
}
