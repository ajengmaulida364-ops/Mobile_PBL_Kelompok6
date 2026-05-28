import 'package:flutter/material.dart';

import '../../../../services/admin/profile_service.dart';

import 'add_profile_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen
    extends StatefulWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen>
      createState() =>
          _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  Map<String, dynamic>? profile;

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    getProfile();
  }

  Future<void> getProfile() async {

    try {

      final data =
          await ProfileService()
              .getProfile();

      setState(() {

        profile = data;

        isLoading = false;
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F7FA),

      appBar: AppBar(

        backgroundColor:
            Colors.teal,

        title: const Text(

          "Profil Sekolah",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton:

          profile == null

              ? FloatingActionButton(

                  backgroundColor:
                      Colors.orange,

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(
                        builder:
                            (_) =>
                                const AddProfileScreen(),
                      ),
                    );
                  },

                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )

              : null,

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : profile == null

              ? const Center(

                  child: Text(
                    "Belum ada profil",
                  ),
                )

              : RefreshIndicator(

                  onRefresh:
                      getProfile,

                  child:
                      SingleChildScrollView(

                    physics:
                        const AlwaysScrollableScrollPhysics(),

                    padding:
                        const EdgeInsets
                            .all(20),

                    child: Container(

                      padding:
                          const EdgeInsets
                              .all(24),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                                20),

                        boxShadow: [

                          BoxShadow(

                            color: Colors
                                .black
                                .withOpacity(
                                    0.05),

                            blurRadius:
                                8,

                            offset:
                                const Offset(
                                    0,
                                    4),
                          ),
                        ],
                      ),

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          /// TOP
                          Row(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Expanded(

                                child:
                                    Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    Text(

                                      profile![
                                              'title'] ??
                                          '',

                                      style:
                                          const TextStyle(

                                        fontSize:
                                            24,

                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(
                                        height:
                                            10),

                                    Text(

                                      profile![
                                              'description'] ??
                                          '',

                                      style:
                                          TextStyle(
                                        color: Colors
                                                .grey[
                                            700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ElevatedButton.icon(

                                style:
                                    ElevatedButton.styleFrom(

                                  backgroundColor:
                                      Colors.orange,
                                ),

                                onPressed:
                                    () async {

                                  final result =
                                      await Navigator.push(

                                    context,

                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              EditProfileScreen(
                                        profile:
                                            profile!,
                                      ),
                                    ),
                                  );

                                  if (result ==
                                      true) {

                                    getProfile();
                                  }
                                },

                                icon:
                                    const Icon(
                                  Icons.edit,
                                  color:
                                      Colors.white,
                                ),

                                label:
                                    const Text(

                                  "Edit",

                                  style:
                                      TextStyle(
                                    color: Colors
                                        .white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                              height:
                                  30),

                          _infoItem(

                            Icons.location_on,

                            profile![
                                    'address'] ??
                                '',
                          ),

                          _infoItem(

                            Icons.email,

                            profile![
                                    'email'] ??
                                '',
                          ),

                          _infoItem(

                            Icons.phone,

                            profile![
                                    'phone'] ??
                                '',
                          ),

                          const SizedBox(
                              height:
                                  30),

                          Row(

                            children: [

                              Expanded(

                                child:
                                    _cardVM(

                                  title:
                                      "Visi",

                                  value:
                                      profile![
                                              'vision'] ??
                                          '',
                                ),
                              ),

                              const SizedBox(
                                  width:
                                      16),

                              Expanded(

                                child:
                                    _cardVM(

                                  title:
                                      "Misi",

                                  value:
                                      profile![
                                              'mission'] ??
                                          '',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _infoItem(

    IconData icon,

    String value,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
              bottom: 16),

      child: Row(

        children: [

          Icon(
            icon,
            color: Colors.teal,
          ),

          const SizedBox(
              width: 12),

          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _cardVM({

    required String title,

    required String value,
  }) {

    return Container(

      padding:
          const EdgeInsets.all(
              18),

      decoration: BoxDecoration(

        color:
            const Color(
                0xffF9FAFB),

        borderRadius:
            BorderRadius.circular(
                18),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Text(

            title,

            style:
                const TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 12),

          Text(value),
        ],
      ),
    );
  }
}