import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  //keys
  final GlobalKey<FormState> _codeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();

  //repositories
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  int resendDuration = 2 * 60; //2 minutes

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusScopeNode());
        },
        child: Scaffold(
          backgroundColor: MyColors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(MySizes.defaultSpace),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is OtpVerifyingState) {
                      //TODO: debug this on Homepage showing
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Loading();
                          });
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: MySizes.defaultSpace * 1.5,
                        ),
                        Image.asset(
                          "assets/images/phone_auth.png",
                          scale: context.height * 0.01,
                        ),
                        const SizedBox(
                          height: MySizes.defaultSpace * 2,
                        ),
                        Text(
                          "Verify your phone",
                          style: MyTextStyles(MyColors.primary).largeTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: MySizes.defaultSpace,
                        ),
                        Text(
                          "We ${(state is OtpSentState) ? "have sent" : "will send"} you a 6-digits verification code to this number",
                          style: MyTextStyles(MyColors.black).defaultTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: MySizes.defaultSpace,
                        ),
                        Form(
                          key: _phoneFormKey,
                          child: TextFormField(
                            controller: _phoneController,
                            validator: (phone) {
                              if (DataValidator.isValidatePhone(
                                  phone!.trim())) {
                                return null;
                              }
                              return "Please provide a valid Phone number";
                            },
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            style: MyTextStyles(MyColors.black).buttonTextStyle,
                            decoration: InputDecoration(
                              fillColor: MyColors.textFieldBackground,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    MySizes.defaultRadius),
                              ),
                              hintText: "Phone No",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: MySizes.defaultSpace,
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(
                                  left: MySizes.defaultSpace,
                                  right: MySizes.defaultSpace * 0.5,
                                ),
                                child: Icon(
                                  Icons.call_rounded,
                                  color: MyColors.primary,
                                ),
                              ),
                              suffix: Material(
                                child: InkWell(
                                  onTap: (state is AuthInitial ||
                                          state is OtpTimeOutState)
                                      ? () {
                                          if (_phoneFormKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<AuthBloc>(context)
                                                .add(SendOtpEvent(
                                                    _phoneController.text
                                                        .trim()));
                                          }
                                        }
                                      : null,
                                  child: (state is OtpSendingState)
                                      ? Text(
                                          "Sending...",
                                          style: MyTextStyles(MyColors.grey)
                                              .defaultTextStyle,
                                        )
                                      : Text(
                                          (state is OtpSentState)
                                              ? "$resendDuration s"
                                              : (state is OtpTimeOutState)
                                                  ? "Resend"
                                                  : "Get Code",
                                          style: MyTextStyles(
                                                  (state is OtpSentState)
                                                      ? MyColors.grey
                                                      : MyColors.primary)
                                              .defaultTextStyle,
                                        ),
                                ),
                              ),
                            ),
                            readOnly: (state is OtpSentState),
                          ),
                        ),
                        (state is OtpSentState)
                            ? Form(
                                key: _codeFormKey,
                                child: TextFormField(
                                  controller: _codeController,
                                  validator: (code) {
                                    if (DataValidator.isValidateCode(code!)) {
                                      return null;
                                    }
                                    return "Invalid Code";
                                  },
                                  keyboardType: TextInputType.number,
                                  maxLength: 6,
                                  style: MyTextStyles(MyColors.black)
                                      .buttonTextStyle,
                                  decoration: InputDecoration(
                                    fillColor: MyColors.textFieldBackground,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          MySizes.defaultRadius),
                                    ),
                                    hintText: "6-digit Verification Code",
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: MySizes.defaultSpace,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: MySizes.defaultSpace,
                        ),
                        MyFilledButton(
                          child: Text(
                            "Confirm",
                            style: MyTextStyles(MyColors.white).buttonTextStyle,
                          ),
                          size: MySizes.maxButtonSize,
                          function: (state is OtpSentState)
                              ? () async {
                                  if (_codeFormKey.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        VerifyOtpEvent(state.verificationId,
                                            _codeController.text.trim()));
                                  }
                                }
                              : null,
                          borderRadius: MySizes.defaultRadius,
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
    );
  }
}
