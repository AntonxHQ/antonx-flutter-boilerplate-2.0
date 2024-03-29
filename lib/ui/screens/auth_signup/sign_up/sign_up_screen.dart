import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/constants/strings.dart';
import 'package:flutter_antonx_boilerplate/core/enums/view_state.dart';
import 'package:flutter_antonx_boilerplate/ui/custom_widgets/custom_text_field.dart';
import 'package:flutter_antonx_boilerplate/ui/custom_widgets/gender_radio_group.dart';
import 'package:flutter_antonx_boilerplate/ui/custom_widgets/image_container.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/auth_signup/sign_up/sign_up_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: SafeArea(
            child: Scaffold(
              // backgroundColor: backgroundColor,
              body: Stack(
                children: [
                  Container(
                      // color: greyColor,
                      ),

                  ///
                  /// Column Contain app Bar And  User profile Image
                  ///
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ///
                        /// ========== This Section Contain Back Button And Avatar =============
                        ///

                        Container(
                          decoration: BoxDecoration(
                              // color: backgroundColor,
                              border: Border.all(
                                  color: Colors.transparent, width: 0.0)),
                          child: Column(
                            children: [
                              const SizedBox(height: 60),

                              ///
                              /// custom app bar
                              ///
                              // AuthenticationAppBar(
                              //   heading: "Sign Up",
                              // ),

                              ///
                              /// UserIcon
                              ///
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 60, bottom: 24),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      /// User profile Avatar
                                      if (model.signUpBody.image != null)
                                        ClipRRect(
                                          child: Image.file(
                                            model.signUpBody.image!,
                                            height: 141,
                                            width: 141,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(200),
                                        )
                                      else
                                        const ImageContainer(
                                          height: 141,
                                          width: 141,
                                          assets:
                                              "assets/static_assets/avatar.png",
                                          radius: 0,
                                        ),

                                      /// Add Image Icon
                                      Positioned(
                                        right: 05,
                                        top: 02,
                                        child: InkWell(
                                          onTap: () {
                                            debugPrint(
                                                'Pick Image button Clicked');
                                            model.pickImage();
                                          },
                                          child: Container(
                                            height: 30.h,
                                            width: 30.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF2E0A9),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///
                        /// =============== This Section Contain Login Form ==============
                        ///

                        Stack(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  // color: backgroundColor,
                                  border: Border.all(
                                      color: Colors.transparent, width: 0.0)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 31),
                              decoration: const BoxDecoration(
                                  // color: greyColor,
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                topLeft: Radius.circular(24),
                              )),
                              child: Form(
                                key: _formKey,
                                child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    /// Contain Facebook, google, apple sign Button

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        // SocialAuthButtons(),
                                      ],
                                    ),

                                    const SizedBox(height: 23),

                                    /// user name field
                                    CustomTextField(
                                      controller: model.userNameController,
                                      validator: (val) {
                                        if (val == null || val.length < 1) {
                                          return 'Please enter your user name';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTap: () {},
                                      onSaved: (val) {
                                        model.signUpBody.name = val;
                                      },
                                      hintText: "Username",
                                      prefixIcon: ImageContainer(
                                        width: 22.w,
                                        height: 22.h,
                                        assets:
                                            "${staticAssetsPath}user_field_icon.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    /// Password field
                                    CustomTextField(
                                      controller: model.passwordController,
                                      obscure: model.passwordVisibility,
                                      validator: (val) {
                                        if (val.length < 1) {
                                          return 'Please enter your password';
                                        } else if (val.length < 8) {
                                          return 'password must include 8 characters';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTap: () {},
                                      onSaved: (val) {
                                        model.signUpBody.password = val;
                                      },
                                      hintText: "Password",
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          model.passwordVisibility
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          size: 18.h,
                                          color: const Color(0xFFB1B1B1),
                                        ),
                                        onPressed: () {
                                          model.togglePasswordVisibility();
                                        },
                                      ),
                                      prefixIcon: ImageContainer(
                                        width: 22.w,
                                        height: 22.h,
                                        assets:
                                            "${staticAssetsPath}pasword_field_icon.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    /// Email field
                                    CustomTextField(
                                      controller: model.emailController,
                                      validator: (val) {
                                        if (!val.toString().trim().isEmail) {
                                          return 'Please Enter a Valid Email';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTap: () {},
                                      onSaved: (val) {
                                        model.signUpBody.email = val;
                                      },
                                      hintText: "Email",
                                      prefixIcon: ImageContainer(
                                        width: 22.w,
                                        height: 22.h,
                                        assets:
                                            "${staticAssetsPath}mail_field_icon.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    /// location field
                                    CustomTextField(
                                      controller: model.locationController,
                                      validator: (val) {
                                        if (val == null || val.length < 1) {
                                          return 'Please enter your location';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTap: () {},
                                      onSaved: (val) {
                                        model.signUpBody.location = val;
                                      },
                                      hintText: "Location",
                                      prefixIcon: ImageContainer(
                                        width: 22.w,
                                        height: 22.h,
                                        assets:
                                            "${staticAssetsPath}location_field_icon.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    /// Row Contain Is Remind radio button
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 21, 0, 41),
                                      child: GenderRadioGroup(model),
                                    ),

                                    // Container(
                                    //   width: 147.w,
                                    //   height: 45.h,
                                    //   child: RectangularButton(
                                    //     radius: 15,
                                    //     text: "Sign Up",
                                    //     onPressed: () async {
                                    //       if (_formKey.currentState!
                                    //           .validate()) {
                                    //         _formKey.currentState!.save();
                                    //         model.requestSignUp();
                                    //       }
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
