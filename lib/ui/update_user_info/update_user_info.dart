import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:blood_donation/data/repositories/form_repository.dart';
import 'package:blood_donation/data/repositories/user_repository.dart';
import 'package:blood_donation/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:blood_donation/logic/blocs/form_bloc/form_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _selectedBloodGroup;

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
      create: (context) => AuthFormBloc(FormRepository()),
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
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<AuthFormBloc, AuthFormState>(
                      builder: (context, authFormState) {
                        print(authFormState);
                        return Column(
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
                            TextFormField(
                              validator: (username) {
                                if (authFormState is UserDataFormState &&
                                    authFormState.isValidName) {
                                  return null;
                                }
                                return "Please Enter a valid Username";
                              },
                              onChanged: (String name) {
                                context
                                    .read<AuthFormBloc>()
                                    .add(NameFormChangedEvent(name: name));
                              },
                              keyboardType: TextInputType.name,
                              controller: usernameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Your name",
                                fillColor: MyColors.textFieldBackground,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.account_circle_outlined,
                                  color: MyColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: MySizes.defaultSpace,
                            ),
                            TextFormField(
                              validator: (email) {
                                if (authFormState is UserDataFormState &&
                                    authFormState.isValidEmail) {
                                  return null;
                                }
                                return "Please Enter a valid Email";
                              },
                              onChanged: (String email) {
                                context
                                    .read<AuthFormBloc>()
                                    .add(EmailFormChangedEvent(email: email));
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                fillColor: MyColors.textFieldBackground,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: MyColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: MySizes.defaultSpace,
                            ),
                            TextFormField(
                              validator: (location) {
                                if (authFormState is UserDataFormState &&
                                    authFormState.isValidLocation) {
                                  return null;
                                }
                                return "Please Enter a valid location";
                              },
                              onChanged: (String location) {
                                context.read<AuthFormBloc>().add(
                                    LocationFormChangedEvent(
                                        location: location));
                              },
                              controller: locationController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Location",
                                fillColor: MyColors.textFieldBackground,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.location_city_outlined,
                                  color: MyColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: MySizes.defaultSpace,
                            ),
                            DropdownButtonFormField<String>(
                              validator: (bloodGroup) {
                                if (bloodGroup != null) {
                                  return null;
                                }
                                return "Please Select Your Blood Group";
                              },
                              decoration: const InputDecoration(
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
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    _selectedBloodGroup = value;
                                  }
                                });
                              },
                            ),
                            const SizedBox(
                              height: MySizes.defaultSpace * 3,
                            ),
                            MyFilledButton(
                              child: Text(
                                "UPDATE",
                                style: MyTextStyles(MyColors.white)
                                    .buttonTextStyle,
                              ),
                              size: MySizes.maxButtonSize,
                              borderRadius: MySizes.defaultRadius,
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  MyUser myUser = MyUser(
                                    username: usernameController.text.trim(),
                                    email: emailController.text.trim(),
                                    bloodGroup: _selectedBloodGroup,
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
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return new Loading();
                                    },
                                  );
                                  bool isComplete = await UserRepository()
                                      .updateUserInfo(myUser);
                                  if (isComplete) {
                                    context
                                        .read<AuthBloc>()
                                        .add(AuthenticatedEvent());
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: MySizes.defaultSpace * 2,
                            ),
                          ],
                        );
                      },
                    ),
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
