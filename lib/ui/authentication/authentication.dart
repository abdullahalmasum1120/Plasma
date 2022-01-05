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
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is OtpSentState) {
            context.read<TimerBloc>().add(TimerStarted(duration: 60 * 2));
          } else {
            context.read<TimerBloc>().add(TimerReset());
          }
          if (authState is OtpExceptionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(authState.firebaseAuthException.code),
              duration: Duration(seconds: 5),
            ));
            context.read<AuthBloc>().add(AuthInitialEvent());
          }
        },
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
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
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
                            style:
                                MyTextStyles(MyColors.primary).largeTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: MySizes.defaultSpace,
                          ),
                          Text(
                            "We ${(authState is OtpSentState) ? "have sent" : "will send"} you a 6-digits verification code to this number",
                            style:
                                MyTextStyles(MyColors.black).defaultTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: MySizes.defaultSpace,
                          ),
                          BlocBuilder<AuthFormBloc, AuthFormState>(
                            builder: (context, formState) {
                              return TextFormField(
                                controller: _phoneController,
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
                                  errorText: formState is AuthOtpFormState &&
                                          formState.isValidPhone
                                      ? null
                                      : "Invalid Phone",
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
                                  suffix: (formState is AuthOtpFormState &&
                                          formState.isValidPhone)
                                      ? Material(
                                          child: InkWell(
                                            onTap: (authState
                                                        is AuthInitialState ||
                                                    authState
                                                        is OtpTimeOutState)
                                                ? () {
                                                    context
                                                        .read<AuthBloc>()
                                                        .sendOtp(
                                                            phone:
                                                                _phoneController
                                                                    .text
                                                                    .trim());
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
                                readOnly: authState is OtpSentState,
                              );
                            },
                          ),
                          SizedBox(
                            height: MySizes.defaultSpace,
                          ),
                          BlocBuilder<AuthFormBloc, AuthFormState>(
                            builder: (context, authFormState) {
                              return Visibility(
                                visible: authState is OtpSentState,
                                child: TextFormField(
                                  controller: _codeController,
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
                                    errorText:
                                        (authFormState is AuthOtpFormState &&
                                                authFormState.isOtpValid)
                                            ? null
                                            : "Invalid Otp",
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
                                        authFormState is AuthOtpFormState &&
                                        authFormState.isOtpValid)
                                    ? () async {
                                        context.read<AuthBloc>().verifyOtp(
                                            otp: _codeController.text.trim(),
                                            verificationId:
                                                authState.verificationId);
                                      }
                                    : null,
                                borderRadius: MySizes.defaultRadius,
                              );
                            },
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
    );
  }
}
