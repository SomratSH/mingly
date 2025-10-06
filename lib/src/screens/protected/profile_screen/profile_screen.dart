import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_dialog.dart';
import 'package:mingly/src/screens/protected/profile_screen/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileProvider = context.watch<ProfileProvider>();
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              // Profile Card
              profileProvider.profileModel == null ||
                      profileProvider.profileModel.data == null
                  ? Center(child: CircularProgressIndicator())
                  : Card(
                      color: Color(0xFF2E2D2C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(0xFFFFFAE5), width: 0.5),
                      ),

                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage:
                              profileProvider.profileModel.data!.avatar == null
                              ? const AssetImage("lib/assets/images/pp.png")
                              : NetworkImage(
                                      profileProvider.profileModel.data!.avatar
                                          .toString(),
                                    )
                                    as ImageProvider,
                        ),
                        title: Text(
                          profileProvider.profileModel.data!.fullName ?? "N/A",
                          style: TextStyle(
                            color: const Color(0xFFFFFAE5),
                            fontSize: 16,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 1.75,
                          ),
                        ),
                        subtitle: Text(
                          profileProvider.profileModel.data!.mobile ?? "N/A",
                          style: TextStyle(
                            color: const Color(0xFFFAE7E7),
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () => context.push("/edit-profile"),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Edit Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.edit, color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              // Membership Status Card
              Card(
                color: Color(0xFF2E2D2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Color(0xFFFFFAE5), width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Membership Status',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            profileProvider
                                    .profileModel
                                    .data!
                                    .membershipStatus ??
                                "N/A",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            profileProvider.profileModel.data!.points
                                    .toString() ??
                                "0",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          "---------------------------------------------",
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${profileProvider.profileModel.data!.currentPoints} /',
                            style: TextStyle(
                              color: const Color(0xFFFFFAE5),
                              fontSize: 24,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                            ),
                          ),
                          Text(
                            '${profileProvider.profileModel.data!.targetPoints} IDR',
                            style: TextStyle(
                              color: const Color(0xFFB1A39E),
                              fontSize: 12,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: 0.33,
                          minHeight: 8,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Gold', style: TextStyle(color: Colors.white70)),
                          Text(
                            'Platinum',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Priority',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Membership details >>',
                          style: TextStyle(color: theme.colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Menu List
              _ProfileMenuItem(icon: Icons.leaderboard, title: 'Leaderboard'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(height: 1, color: Colors.white),
              ),
              _ProfileMenuItem(
                icon: Icons.language,
                title: 'Language',
                trailing: 'English',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(height: 1, color: Colors.white),
              ),
              _ProfileMenuItem(icon: Icons.settings, title: 'Account Settings'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(height: 1, color: Colors.white),
              ),
              _ProfileMenuItem(icon: Icons.payment, title: 'Payment Method'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(height: 1, color: Colors.white),
              ),
              _ProfileMenuItem(
                icon: Icons.book_online,
                title: 'My Reservation',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(height: 1, color: Colors.white),
              ),
              _ProfileMenuItem(icon: Icons.history, title: 'Point History'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(height: 1, color: Colors.white),
              ),
              _ProfileMenuItem(icon: Icons.card_giftcard, title: 'My Voucher'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(height: 1, color: Colors.white),
              ),
              _ProfileMenuItem(
                icon: Icons.logout,
                title: 'Log Out',
                onTap: () => showLogoutDialog(context),
              ),
              const SizedBox(height: 24),
              // Update Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  Function()? onTap;
  _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        trailing: trailing != null
            ? Text(trailing!, style: const TextStyle(color: Colors.white70))
            : const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 12,
              ),
        onTap: onTap,
      ),
    );
  }
}
