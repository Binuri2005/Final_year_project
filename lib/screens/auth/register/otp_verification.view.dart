import 'package:app/global/button.widget.dart';
import 'package:app/viewmodels/auth/auth_viewmodel..dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class OtpVerificationView extends StatefulWidget {
  final String email;
  const OtpVerificationView({super.key, required this.email});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  String otp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/signup_background.png'), // Background image
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Verify your email",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              Text(
                'Enter the OTP sent to ${widget.email}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 50,
                  onChanged: (pin) {
                    setState(() {
                      otp = pin;
                    });
                  },
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),
              ),
              SizedBox(height: 20),
              PrimaryButton(
                text: 'Verify',
                isLoading: context.watch<AuthViewModel>().isRegisteringUser,
                onPressed: () {
                  if (otp.length != 4) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please enter a valid OTP'),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }

                  context.read<AuthViewModel>().verifyOTP(
                        email: widget.email,
                        otp: otp,
                        onSuccess: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        onFailure: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                context.read<AuthViewModel>().errorMessage!),
                            backgroundColor: Colors.red,
                          ));
                        },
                      );
                },
              ),
            ],
          ),

          // cloud Animation
        ),
      ),
    );
  }
}
