import 'package:flutter/material.dart';

class Profile {
  const Profile({
    required this.name,
    required this.interests,
    required this.imageURL,
    required this.userid,
  });
  final String name;
  final String interests;
  final String imageURL;
  final String userid;
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  Widget _buildChip(String label) {
    return Chip(
      labelPadding: EdgeInsets.all(0),
      // avatar: CircleAvatar(
      //   backgroundColor: Colors.white70,
      //   child: Text(label[0].toUpperCase()),
      // ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.redAccent,
      elevation: 3.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(5.0),
    );
  }

  Widget chipList(List<String> interestsList) {
    if (interestsList.length > 4) {
      List<String> temp = interestsList.sublist(0, 4);
      return Wrap(
          spacing: 3.0,
          children:
          temp.map((interest) => _buildChip(interest)).toList());
    }
    return Wrap(
        spacing: 3.0,
        children:
            interestsList.map((interest) => _buildChip(interest)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 630,
      width: 340,
      padding: const EdgeInsets.only(bottom: 60),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(profile.imageURL, fit: BoxFit.fitHeight),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 115,
              width: 340,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profile.name,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    profile.interests == ""
                        ? Text("No interests listed")
                        : chipList(profile.interests
                            .substring(1, profile.interests.length - 1)
                            .split(',')
                            .map((x) => x.trim())
                            .toList()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
