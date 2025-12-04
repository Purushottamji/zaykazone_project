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
  bool passwordVisible = false;
  bool rePasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    var register = Provider.of<SignupProvider>(context);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ClipPath(
            clipper: TopClipPath(),
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Color(0xffFF620D),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 24,
                        ),
<<<<<<< HEAD
                      )
=======
                      ),
                      SizedBox(height: 3),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "INTER Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 3),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "INTER Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 3),
                      TextFormField(
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          hintText: "INTER Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "RE-TYPE PASSWORD",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 3),
                      TextFormField(
                        obscureText: !rePasswordVisible,
                        decoration: InputDecoration(
                          hintText: "INTER RE-TYPE PASSWORD",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              rePasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                rePasswordVisible = !rePasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 70,
                            ),
                            backgroundColor: Color(0xffFF620D),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("SIGN UP",style: TextStyle(color: Colors.white),),
                        ),
                      ),
>>>>>>> 8dc6666eaef6b44ed5c9d90370a07e080bb0a1a3
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Sign Up Now",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Please create your account",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      register.pickImage(ImageSource.gallery);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      backgroundImage: register.imageFile != null
                          ? FileImage(register.imageFile!)
                          : null,
                      child: register.imageFile == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 35,
                              color: Colors.grey.shade700,
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Form(
            key: register.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.02),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your Name";
                      }
                      return null;
                    },
                    decoration: customInput("Enter Name"),
                  ),
                  SizedBox(height: h * 0.02),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your email";
                      }
                      if (!value.contains("@") || !value.contains(".com")) {
                        return "Email must be valid";
                      }
                      return null;
                    },
                    decoration: customInput("Enter Email"),
                  ),
                  SizedBox(height: h * 0.02),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your Phone";
                      }
                      if (value.length != 10) {
                        return "Phone must be 10 digits";
                      }
                      return null;
                    },
                    decoration: customInput("Enter Phone"),
                  ),
                  SizedBox(height: h * 0.02),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.passwordController,
                    obscureText: register.showPass1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFF620D)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        onPressed: register.togglePass1,
                        icon: register.showPass1
                            ? Icon(CupertinoIcons.eye_slash_fill)
                            : Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: register.cPasswordController,
                    obscureText: register.showPass2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Re-enter Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFF620D)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        onPressed: register.togglePass2,
                        icon: register.showPass2
                            ? Icon(CupertinoIcons.eye_slash_fill)
                            : Icon(Icons.remove_red_eye),
                      ),
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
        borderSide: BorderSide(color: Color(0xffFF620D)),
      ),
    );
  }
}

class TopClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
