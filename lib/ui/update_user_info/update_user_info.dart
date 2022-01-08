import 'package:blood_donation/app/app_bloc/app_bloc.dart';
import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'logic/cubits/user_data/form_cubit.dart';

class UpdateUserDataPage extends StatefulWidget {
  const UpdateUserDataPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateUserDataPage> createState() => _UpdateUserDataPageState();
}

class _UpdateUserDataPageState extends State<UpdateUserDataPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataFormCubit(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Scaffold(
            backgroundColor: MyColors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(MySizes.defaultSpace),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: MySizes.defaultSpace * 1.5,
                      ),
                      SvgPicture.asset(
                        "assets/icons/logo.svg",
                        height: MySizes.largeIconSize,
                        width: MySizes.largeIconSize,
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Dare ",
                            style: TextStyle(
                              color: MyColors.primary,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "To ",
                            style: TextStyle(
                              color: MyColors.black,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "Donate ",
                            style: TextStyle(
                              color: MyColors.primary,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace * 2,
                      ),
                      BlocBuilder<UserDataFormCubit, UserDataFormState>(
                        builder: (context, formState) {
                          return TextFormField(
                            onChanged: (String name) {
                              context
                                  .read<UserDataFormCubit>()
                                  .nameChanged(name);
                            },
                            keyboardType: TextInputType.name,
                            controller: usernameController,
                            decoration: InputDecoration(
                              errorText:
                                  formState.isValidName ? null : "Invalid name",
                              border: InputBorder.none,
                              hintText: "Your name",
                              fillColor: MyColors.textFieldBackground,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.account_circle_outlined,
                                color: MyColors.primary,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace,
                      ),
                      BlocBuilder<UserDataFormCubit, UserDataFormState>(
                        builder: (context, formState) {
                          return TextFormField(
                            onChanged: (String email) {
                              context
                                  .read<UserDataFormCubit>()
                                  .emailChanged(email);
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorText: formState.isValidEmail
                                  ? null
                                  : "Invalid Email",
                              border: InputBorder.none,
                              hintText: "Email",
                              fillColor: MyColors.textFieldBackground,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: MyColors.primary,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace,
                      ),
                      BlocBuilder<UserDataFormCubit, UserDataFormState>(
                        builder: (context, formState) {
                          return TextFormField(
                            onChanged: (String location) {
                              context
                                  .read<UserDataFormCubit>()
                                  .locationChanged(location);
                            },
                            controller: locationController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorText: formState.isValidLocation
                                  ? null
                                  : "Invalid Location",
                              border: InputBorder.none,
                              hintText: "Location",
                              fillColor: MyColors.textFieldBackground,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.location_city_outlined,
                                color: MyColors.primary,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace,
                      ),
                      BlocBuilder<UserDataFormCubit, UserDataFormState>(
                        builder: (context, formState) {
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              errorText: formState.isValidBloodGroup
                                  ? null
                                  : "Not Selected",
                              border: InputBorder.none,
                              fillColor: MyColors.textFieldBackground,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.bloodtype,
                                color: MyColors.primary,
                              ),
                            ),
                            hint: const Text("Blood Group"),
                            items: <String>[
                              'A+',
                              'A-',
                              'B+',
                              'B-',
                              'O+',
                              'O-',
                              'AB+',
                              'AB-',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (bloodGroup) {
                              if (bloodGroup != null) {
                                context
                                    .read<UserDataFormCubit>()
                                    .bloodGroupChanged(bloodGroup);
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace * 3,
                      ),
                      BlocBuilder<UserDataFormCubit, UserDataFormState>(
                        builder: (context, formState) {
                          return MyFilledButton(
                            child: Text(
                              formState.isLoading ? "Updating" : "UPDATE",
                              style:
                                  MyTextStyles(MyColors.white).buttonTextStyle,
                            ),
                            size: MySizes.maxButtonSize,
                            borderRadius: MySizes.defaultRadius,
                            function: () async {
                              if (formState.isValidLocation &&
                                  formState.isValidEmail &&
                                  formState.isValidName &&
                                  formState.isValidBloodGroup) {
                                MyUser myUser = MyUser(
                                  username: usernameController.text.trim(),
                                  email: emailController.text.trim(),
                                  bloodGroup: formState.selectedBloodGroup,
                                  location: locationController.text.trim(),
                                  registrationTime: DateFormat('kk:mm')
                                      .format(DateTime.now()),
                                  registrationDate: DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now()),
                                  donated: 0,
                                  requested: 0,
                                  isAvailable: false,
                                  phone: FirebaseAuth
                                      .instance.currentUser!.phoneNumber,
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                );

                                await context
                                    .read<UserDataFormCubit>()
                                    .formSubmitted(myUser);
                                context
                                    .read<AppBloc>()
                                    .add(AppAuthenticatedEvent());
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace * 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
