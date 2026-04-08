import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final name = TextEditingController();
  final phone = TextEditingController();

  File? image;
  String? currentImage;

  bool loading = true;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  /// pick image
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  /// upload image to Cloudinary
  Future<String?> uploadImage() async {
    if (image == null) return null;

    final cloudinary = CloudinaryPublic(
      'cloud_name',
      'upload_preset',
      cache: false,
    );

    final response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(image!.path, folder: "users/$uid"),
    );

    return response.secureUrl;
  }

  /// load user data
  Future<void> loadUserData() async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    final data = doc.data();

    name.text = data?["name"] ?? "";
    phone.text = data?["phone"] ?? "";
    currentImage = data?["image"];

    setState(() {
      loading = false;
    });
  }

  /// update profile
  Future updateProfile() async {
    String? imageUrl = await uploadImage();

    final data = {"name": name.text, "phone": phone.text};

    if (imageUrl != null) {
      data["image"] = imageUrl;
    }

    await FirebaseFirestore.instance.collection("users").doc(uid).update(data);

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Edit Profile"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),

        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// avatar
              GestureDetector(
                onTap: pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color(0xFF1E1E1E),

                      backgroundImage: image != null
                          ? FileImage(image!)
                          : (currentImage != null && currentImage!.isNotEmpty)
                          ? NetworkImage(currentImage!)
                          : null,

                      child:
                          image == null &&
                              (currentImage == null || currentImage!.isEmpty)
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white70,
                            )
                          : null,
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// name
              TextField(
                controller: name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Full Name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF1E1E1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// phone
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF1E1E1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// save button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  onPressed: updateProfile,

                  child: const Text(
                    "Save Changes",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
