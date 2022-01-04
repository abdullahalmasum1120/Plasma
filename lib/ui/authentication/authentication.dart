import 'package:blood_donation/data/repositories/form_repository.dart';
import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:blood_donation/logic/blocs/form_bloc/form_bloc.dart';
import 'package:blood_donation/logic/blocs/timer_bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final GlobalKey<FormState> _codeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthFormBloc(FormRepository()),
        ),
        BlocProvider(
          create: (context) => TimerBloc(ticker: Ticker()),
        ),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is OtpSentState) {
            context.read<TimerBloc>().add(TimerStarted(duration: 60 * 2));
          } else {
            context.read<TimerBloc>().add(TimerReset());
          }
          if (authState is AuthenticationFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(authState.firebaseAuthException.code),
              duration: Duration(seconds: 4),
            ));
            context.read<AuthBloc>().add(AppStartedEvent());
          }
        },
        builder: (context, authState) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusScopeNode());
            },
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
                          "We ${(authState is OtpSentState) ? "have sent" : "will send"} you a 6-digits verification code to this number",
                          style: MyTextStyles(MyColors.black).defaultTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: MySizes.defaultSpace,
                        ),
                        BlocBuilder<AuthFormBloc, AuthFormState>(
                          builder: (context, authFormState) {
                            return Form(
                              key: _phoneFormKey,
                              child: TextFormField(
                                controller: _phoneController,
                                validator: (String? phone) {
                                  if (authFormState is PhoneFormState &&
                                      authFormState.isValidPhone) {
                                    return null;
                                  }
                                  return "Please Provide a Valid phone number";
                                },
                                onChanged: (String phone) {
                                  context.read<AuthFormBloc>().add(
                                        PhoneFormChangedEvent(phone: phone),
                                      );
                                },
                                keyboardType: TextInputType.phone,
                                style: MyTextStyles(MyColors.black)
                                    .buttonTextStyle,
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
                                  suffix: (authFormState is PhoneFormState &&
                                          authFormState.isValidPhone)
                                      ? Material(
                                          child: InkWell(
                                            onTap: (authState is AuthInitial ||
                                                    authState
                                                        is OtpTimeOutState)
                                                ? () {
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(SendOtpEvent(
                                                            _phoneController
                                                                .text
                                                                .trim()));
                                                  }
                                                : null,
                                            child: BlocBuilder<TimerBloc,
                                                TimerState>(
                                              builder: (context, timerState) {
                                                return Text(
                                                  (authState is OtpSentState)
                                                      ? timerState.duration
                                                          .toString()
                                                      : (authState
                                                              is OtpTimeOutState)
                                                          ? "Resend"
                                                          : (authState
                                                                  is OtpSendingState)
                                                              ? "sending..."
                                                              : "Get Code",
                                                  style: MyTextStyles((authState
                                                                  is OtpSentState ||
                                                              authState
                                                                  is OtpSendingState)
                                                          ? MyColors.grey
                                                          : MyColors.primary)
                                                      .defaultTextStyle,
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                readOnly: (authState is OtpSentState),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: MySizes.defaultSpace,
                        ),
                        BlocBuilder<AuthFormBloc, AuthFormState>(
                          builder: (context, authFormState) {
                            return Visibility(
                              visible: (authState is OtpSentState),
                              child: Form(
                                key: _codeFormKey,
                                child: TextFormField(
                                  controller: _codeController,
                                  validator: (String? code) {
                                    if (authFormState is OtpFormState &&
                                        authFormState.isOtpValid) {
                                      return null;
                                    }
                                    return "Otp is not correct";
                                  },
                                  onChanged: (String otp) {
                                    context.read<AuthFormBloc>().add(
                                          OtpFormChangedEvent(otp: otp),
                                        );
                                  },
                                  keyboardType: TextInputType.number,
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
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: MySizes.defaultSpace,
                        ),
                        BlocBuilder<AuthFormBloc, AuthFormState>(
                          builder: (context, authFormState) {
                            return MyFilledButton(
                              child: Text(
                                (authState is OtpVerifyingState)
                                    ? "Verifying"
                                    : "Confirm",
                                style: MyTextStyles(MyColors.white)
                                    .buttonTextStyle,
                              ),
                              size: MySizes.maxButtonSize,
                              function: (authState is OtpSentState &&
                                      authFormState is OtpFormState &&
                                      authFormState.isOtpValid)
                                  ? () async {
                                      if (_codeFormKey.currentState!
                                          .validate()) {
                                        context.read<AuthBloc>().add(
                                            VerifyOtpEvent(
                                                authState.verificationId,
                                                _codeController.text.trim()));
                                        _codeController.text = "";
                                      }
                                    }
                                  : null,
                              borderRadius: MySizes.defaultRadius,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
