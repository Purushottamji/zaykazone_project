import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_auth_provider/signup_provider/signup_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    var register = Provider.of<SignupProvider>(context);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,),

      body: ListView(
        children: [
          SizedBox(height: h * 0.02),
          Center(
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: w * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          SizedBox(height: h * 0.01),

          Center(
            child: Text(
              "Please sign up to get started",
              style: TextStyle(fontSize: w * 0.04, color: Colors.black87),
            ),
          ),

          SizedBox(height: h * 0.005),

          Form(
            key: register.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.02),

                  Center(
                    child: InkWell(
                      onTap: () {
                        register.pickImage(ImageSource.gallery);
                      },
                      child: CircleAvatar(
                        radius: w * 0.14,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            register.imageFile != null
                                ? FileImage(register.imageFile!)
                                : null,
                        child:
                            register.imageFile == null
                                ? Icon(
                                  Icons.camera_alt,
                                  size: w * 0.10,
                                  color: Colors.grey.shade700,
                                )
                                : null,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  Text(
                    "NAME",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.nameController,
                    decoration: customInput("Enter Name"),
                  ),

                  SizedBox(height: h * 0.02),

                  Text(
                    "EMAIL",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: customInput("Enter Email"),
                  ),

                  SizedBox(height: h * 0.02),
                  Text(
                    "PHONE",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.phoneController,
                     keyboardType: TextInputType.phone,
                    decoration: customInput("Enter Phone"),
                  ),

                  SizedBox(height: h * 0.02),

                  Text(
                    "PASSWORD",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.passwordController,
                    obscureText: register.showPass1,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      suffixIcon: IconButton(onPressed: register.togglePass1, icon: register.showPass1 ? Icon(CupertinoIcons.eye_slash_fill):Icon(Icons.remove_red_eye))
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  Text(
                    "RE-TYPE PASSWORD",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.cPasswordController,
                    obscureText: register.showPass2,
                    decoration: InputDecoration(
                        hintText: "Re-enter Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: IconButton(onPressed: register.togglePass2, icon: register.showPass2 ? Icon(CupertinoIcons.eye_slash_fill):Icon(Icons.remove_red_eye))
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFF620D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          register.registerUser(context);
                        },
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration customInput(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }
}
