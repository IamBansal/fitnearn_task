import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'ImagePathHandler.dart';
import 'MainScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

const List<String> list = <String>['Male', 'Female'];

class _ProfileScreenState extends State<ProfileScreen> {
  bool _enable = false;

  @override
  void initState() {
    super.initState();
    setImage();
    _getNameNumber();
  }

  Future<void> setImage() async {
    String? retrievedImagePath = await ImagePathHandler.getImagePath();
    if (retrievedImagePath != null) {
      setState(() {
        _imageFile = File(retrievedImagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        elevation: MaterialStateProperty.all(20)),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF5271EF),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'My Profile',
                    style: TextStyle(
                        color: Color(0xFF5271EF),
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        elevation: MaterialStateProperty.all(20)),
                    icon: Icon(
                      _enable
                          ? Icons.edit_off_outlined
                          : Icons.mode_edit_outline_outlined,
                      color: const Color(0xFF5271EF),
                    ),
                    onPressed: () {
                      setState(() {
                        _enable = !_enable;
                      });
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.transparent,
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera, color: Color(0xFF5271EF)),
                            title: const Text('Take Photo'),
                            onTap: () {
                              Navigator.pop(context); // Close the bottom sheet
                              getImage(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_library, color: Color(0xFF5271EF),),
                            title: const Text('Choose from Gallery'),
                            onTap: () {
                              Navigator.pop(context);
                              getImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF5271EF), width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(
                      children: [
                        const Positioned(
                          bottom: 1,
                          right: 1,
                          child: Icon(Icons.add_a_photo, color: Color(0xFF5271EF),),
                        ),
                      _imageFile != File('') ? CircleAvatar(backgroundImage: FileImage(_imageFile), radius: 50.0,) : ClipOval(
                            child: Image.asset(
                              'assets/pic.png',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ))
                      ],
                    ),
                  )
              ),
            ),
            const SizedBox(height: 30),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38.0),
                  child: Text(
                    "General Details",
                    style: TextStyle(
                        color: Color(0xFF5271EF),
                        fontSize: 23,),
                    textAlign: TextAlign.right,
                  ),
                )),
            const SizedBox(height: 10),
            SizedBox(
              width: 340,
              height: 50,
              child: TextField(
                enabled: _enable,
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
                    enabled: _enable,
                    hintText: 'Gender',
                    initialSelection: list.first,
                    onSelected: (String? value) {
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
                      enabled: _enable,
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
                enabled: _enable,
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

            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38.0),
                  child: Text(
                    "Contact Details",
                    style: TextStyle(
                      color: Color(0xFF5271EF),
                      fontSize: 23,),
                    textAlign: TextAlign.right,
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 340,
              height: 50,
              child: TextField(
                enabled: _enable,
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
                    counterText: ''
                ),
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.black),
                maxLength: 10,
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            SizedBox(
              width: 340,
              height: 50,
              child: TextField(
                enabled: _enable,
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
                enabled: _enable,
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
            const SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: 190,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const MainScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.save_outlined, color: Colors.white,),
                    SizedBox(width: 8.0),
                    Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ));
  }

  Future<void> _saveNameNumber() async{
    await ImagePathHandler.saveName(_usernameController.text, _numberController.text, gender, _dobController.text, _addressController.text);
  }

  Future<void> _getNameNumber() async{
    List<String>? list = await ImagePathHandler.getName();
    setState(() {
      _usernameController.text = list!.first;
      _numberController.text = list.last;
      _addressController.text = list[3];
      _dobController.text = list[2];
      gender = list[1];
    });
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _numberController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  bool _obscureText = true;
  DateTime selectedDate = DateTime.now();
  String gender = list.first;

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

  File _imageFile = File('');
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await ImagePathHandler.saveImagePath(pickedFile.path);
    }
  }

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