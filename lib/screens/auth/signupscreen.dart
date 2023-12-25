import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../providers/ImagePathHandler.dart';
import 'LoginScreen.dart';
import '../MainScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
const List<String> list = <String>['Male', 'Female'];


class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _numberController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> signUpWithEmailAndPassword(
  //     String email, String password, BuildContext context) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return GestureDetector(
  //           onTap: () {
  //             Navigator.of(context).pop();
  //             Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => MainScreen(),
  //               ),
  //             );
  //           },
  //           child: Dialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0),
  //             ),
  //             child: Container(
  //               height: 200,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(12.0),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const Center(
  //                       child: Text(
  //                         "Sign-up Successful",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 20,
  //                           color: Colors.greenAccent,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 20),
  //                     const Center(
  //                       child: Text(
  //                         "You have successfully signed up!",
  //                         style: TextStyle(
  //                           fontSize: 18,
  //                           color: Colors.black54,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 20),
  //                     Center(
  //                       child: SizedBox(
  //                         width: 320.0,
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             primary: Colors.greenAccent,
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(30.0),
  //                             ),
  //                           ),
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.pushReplacement(
  //                               context,
  //                               MaterialPageRoute(
  //                                 builder: (context) => MainScreen(),
  //                               ),
  //                             );
  //                           },
  //                           child: const Text(
  //                             "Continue",
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 20,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return GestureDetector(
  //           onTap: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: Dialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0),
  //             ),
  //             child: Container(
  //               height: 200,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(12.0),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const Center(
  //                       child: Text(
  //                         "Sign-up Failed",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 20,
  //                           color: Colors.redAccent,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 20),
  //                     Center(
  //                       child: Text(
  //                         e.toString(),
  //                         style: const TextStyle(
  //                           fontSize: 18,
  //                           color: Colors.black54,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 20),
  //                     Center(
  //                       child: SizedBox(
  //                         width: 320.0,
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             primary: Colors.redAccent,
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(30.0),
  //                             ),
  //                           ),
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           child: const Text(
  //                             "Close",
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 20,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _numberController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobController.text = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      });
    }
  }

  // Location location;
  // late bool _serviceEnabled;
  // late PermissionStatus _permissionGranted;
  // late LocationData _locationData;
  // String _address = '';

  @override
  void initState() {
    super.initState();
    // _checkLocationPermission();
  }


  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  // Future<Position> _getLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }

  // Future<void> _checkLocationPermission() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  // }
  //
  // Future<void> _getLocation() async {
  //   bool _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   PermissionStatus _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   LocationData _locationData = await location.getLocation();
  //   setState(() {
  //     this._locationData = _locationData;
  //   });
  //   // _locationData = await location.getLocation();
  //   _getAddressFromLatLng();
  // }
  //
  // Future<void> _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       _locationData.latitude!,
  //       _locationData.longitude!,
  //     );
  //
  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks[0];
  //       setState(() {
  //         _address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  //       });
  //       print(_address);
  //       _addressController.text = _address;
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }


  String gender = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset('assets/pic.png'),
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38.0),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color(0xFF5271EF),
                          fontSize: 33,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                  )),
              const SizedBox(height: 30),
              SizedBox(
                width: 340,
                height: 50,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    hintText: 'Enter Full Name',
                    hintStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    hintMaxLines: 1,
                    labelText: 'Full Name',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownMenu<String>(
                      hintText: 'Gender',
                      initialSelection: list.first,
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          gender = value!;
                        });
                      },
                      inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Color(0xFF5271EF)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Color(0xFF5271EF)),
                        ),
                      ),
                      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(value: value, label: value);
                      }).toList(),
                    ),
                    SizedBox(
                      width: 180,
                      height: 60,
                      child: TextField(
                        controller: _dobController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Color(0xFF5271EF)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Color(0xFF5271EF)),
                          ),
                          hintText: 'Enter D.O.B',
                          hintStyle: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                          hintMaxLines: 1,
                          labelText: 'D.O.B',
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_month_outlined, color: Color(0xFF5271EF)),
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                          counterText: ''
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(color: Colors.black),
                        maxLength: 10,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 340,
                height: 50,
                child: TextField(
                  controller: _numberController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    hintText: 'Enter Mobile Number',
                    hintStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    hintMaxLines: 1,
                    labelText: 'Mobile Number',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              SizedBox(
                width: 340,
                height: 50,
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    hintText: 'Enter Address',
                    hintStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    hintMaxLines: 1,
                    labelText: 'Address',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.location_on_outlined, color: Color(0xFF5271EF)),
                      onPressed: () {
                        _getCurrentPosition();
                      },
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              SizedBox(
                width: 340,
                height: 50,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    hintText: 'Enter your email',
                    hintStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    hintMaxLines: 1,
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              SizedBox(
                width: 340,
                height: 50,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    hintMaxLines: 1,
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFF5271EF)),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        // Handle the checkbox state change here
                        setState(() {
                          _rememberMe =
                              value ?? false; // Update the state of rememberMe
                        });
                      },
                      side: const BorderSide(
                        color: Color(0xFF5271EF),
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      checkColor: const Color(0xFF5271EF),
                      activeColor: _rememberMe ? Colors.white : Colors.white,
                    ),
                    const Text(
                      'Remember Me',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 90,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ForgotPassword(),
                          //     ));
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 13, color: Color(0xFF5271EF)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "By signing you are agreeing to our",
                style: TextStyle(color: Colors.black),
              ),
              const Text(
                "Terms and Privacy policy",
                style: TextStyle(color: Color(0xFF5271EF)),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 140,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5271EF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29),
                      side: const BorderSide(color: Color(0xFF5271EF)),
                    ),
                  ),
                  onPressed: () {
                      _saveNameNumber();
                      signUpWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                        context,
                      );
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(thickness: 1.0, color: Colors.grey,),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveNameNumber() async{
    await ImagePathHandler.saveName(_usernameController.text, _numberController.text, gender, _dobController.text, _addressController.text);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {

      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      if(emailRegex.hasMatch(email) && password.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        ).whenComplete(() =>
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainScreen()),
            )
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await GeocodingPlatform.instance.placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude, localeIdentifier: 'en')
        .then((placeMarks) {
      if(placeMarks.isNotEmpty) {
        Placemark place = placeMarks[0];
        setState(() {
          _addressController.text =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
        });
      }
    }).catchError((e) {
      setState(() {
        _addressController.text = 'Unable to get the address';
      });
      debugPrint(e.toString());
    });
  }

}
