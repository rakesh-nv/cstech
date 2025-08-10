import 'package:cstech_test/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/validators.dart';
import '../../widgets/CustomInputField.dart';
import '../../widgets/customButton.dart';

class AuthScreen extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Colors.red,
              border: Border(
                top: BorderSide(color: Colors.grey.shade600),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                authController.isLogin.value
                    ? _buildLoginForm()
                    : _buildSignupForm(),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/images/img1.png', // replace with your logo path
          height: 60,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: authController.signInFormKey,
      child: Column(
        children: [
          Text(
            'Welcome!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Please register to continue',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height:30),
          CustomInputField(
            hintText: 'Email address',
            suffixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            controller: authController.emailController,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 16),
          CustomInputField(
            hintText: 'Password',
            obscureText: false,
            suffixIcon: Icons.lock_outline,
            controller: authController.passwordController,
            validator: Validators.validatePassword,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200),
            child: Text('Forgot Password?',style: TextStyle(color: Colors.blue),),
          ),
          const SizedBox(height: 200),
          _buildToggleText(),
          const SizedBox(height: 20),
          Obx(() => CustomButton(
            text: authController.isLoading.value ? 'Signing In...' : 'Sign In',
            onPressed: authController.isLoading.value
                ? null
                : () => authController.submitLogin(),
          )),
          const SizedBox(height: 16),

        ],
      ),
    );
  }

  Widget _buildSignupForm() {
    return Form(
      key: authController.signUpFormKey,
      child: Column(
        children: [
          Text(
            'Welcome!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Please register to continue',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 28),

          CustomInputField(
            hintText: 'Name',
            suffixIcon: Icons.person_outline,
            controller: authController.nameController,
            validator: Validators.validateName,
          ),
          const SizedBox(height: 16),
          CustomInputField(
            hintText: 'Email address',
            suffixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            controller: authController.emailController,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 16),
          Obx(() => CustomInputField(
            hintText: 'Password',
            obscureText: authController.obscurePassword.value,
            suffixIcon: authController.obscurePassword.value
                ? Icons.visibility_off
                : Icons.visibility,
            // onSuffixTap: authController.toggleObscurePassword,
            controller: authController.passwordController,
            validator: Validators.validatePassword,
          )),
          const SizedBox(height: 16),
          CustomInputField(
            hintText: 'Mobile number',
            suffixIcon: Icons.phone_android,
            controller: authController.mobileController,
            keyboardType: TextInputType.phone,
            validator: Validators.validateMobile,
          ),
          const SizedBox(height: 10),
          Obx(() => Row(
            children: [
              Checkbox(
                value: authController.agreeToTerms.value,
                onChanged: authController.toggleTermsAgreement,
              ),
              const Text('I agree to the '),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          )),
          const SizedBox(height: 16),
          _buildToggleText(),
          const SizedBox(height: 16),
          Obx(() => CustomButton(
            text: authController.isLoading.value ? 'Registering...' : 'Sign Up',
            onPressed: authController.isLoading.value
                ? null
                : () => authController.startOtpVerification(),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildToggleText() {
    return GestureDetector(
      onTap: authController.toggleAuthMode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            authController.isLogin.value
                ? "Don't have an account? "
                : "Already have an account? ",
          ),
          Text(
            authController.isLogin.value ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
