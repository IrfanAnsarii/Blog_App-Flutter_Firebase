import 'package:blog/auth/login_screen.dart';
import 'package:blog/models/blog.dart';
import 'package:blog/screens/add_blog/add_blog_screen.dart';
import 'package:blog/screens/home/widgets/item_blog.dart';
import 'package:blog/screens/myBlog/my_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOutSine),
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 16, left: 16),
              title: const Text(
                'Narrative Nexus',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [Shadow(color: Colors.black87, blurRadius: 8)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _waveAnimation,
                    builder: (context, child) {
                      return ClipPath(
                        clipper: WaveClipper(_waveAnimation.value),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white10, Colors.white24],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 16,
                    top: 40,
                    child: _buildProfileButton(),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.8,
                  colors: [const Color(0xFF0A0E21), Colors.black.withOpacity(0.9)],
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 300,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _glowAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_glowAnimation.value * 0.1),
                              child: CircularProgressIndicator(
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00E5FF)),
                                strokeWidth: 5,
                                backgroundColor: Colors.white.withOpacity(0.1),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    print('Firestore error: ${snapshot.error}');
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: Text(
                          'Error Loading Cosmos',
                          style: TextStyle(fontSize: 24, color: Colors.redAccent, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: Text(
                          'No Cosmic Tales Found',
                          style: TextStyle(fontSize: 22, color: Colors.white38),
                        ),
                      ),
                    );
                  }

                  final data = snapshot.data!.docs;
                  List<Blog> blogs = [];
                  for (var element in data) {
                    Blog blog = Blog.fromMap(element.data() as Map<String, dynamic>);
                    blogs.add(blog);
                  }

                  if (blogs.isEmpty) {
                    return SizedBox(
                      height: 450,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _glowAnimation,
                          builder: (context, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: 1.0 + (_glowAnimation.value * 0.05),
                                  child: Icon(Icons.auto_stories_rounded, size: 120, color: const Color(0xFF00E5FF)),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'Launch a New Saga',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    shadows: [Shadow(color: Color(0xFF00E5FF), blurRadius: 10)],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'The universe awaits your story.',
                                  style: TextStyle(fontSize: 18, color: Colors.white60, fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(height: 25),
                                ElevatedButton(
                                  onPressed: () => _navigateToAddBlog(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00E5FF),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                    elevation: 15,
                                    shadowColor: const Color(0xFF00E5FF).withOpacity(0.5),
                                  ),
                                  child: const Text(
                                    'Ignite Creation',
                                    style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedBuilder(
                          animation: _glowAnimation,
                          builder: (context, child) {
                            return Text(
                              'Galactic Narratives',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                shadows: [
                                  Shadow(
                                    color: const Color(0xFF00E5FF).withOpacity(_glowAnimation.value * 0.5),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        ...blogs.map((blog) => _buildBlogTile(blog)).toList(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00E5FF).withOpacity(_glowAnimation.value * 0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () => _navigateToAddBlog(context),
              backgroundColor: const Color(0xFF00E5FF),
              elevation: 0,
              shape: const CircleBorder(),
              child: const Icon(Icons.add_rounded, size: 40, color: Colors.black87),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildProfileButton() {
    return PopupMenuButton(
      icon: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white24,
        child: Icon(Icons.person_rounded, color: Colors.white, size: 24),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      offset: const Offset(0, 40),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const MyBlogScreen()));
          },
          child: const Text('My Stories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        PopupMenuItem(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
            );
          },
          child: const Text('Sign Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildBlogTile(Blog blog) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          // Navigate to blog detail (implement as needed)
        },
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00E5FF), Color(0xFF0288D1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withOpacity(_glowAnimation.value * 0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                  BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [Colors.white.withOpacity(0.05), Colors.transparent],
                          center: Alignment.topLeft,
                          radius: 1.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: ItemBlog(blog: blog),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(25),
                          splashColor: Colors.white.withOpacity(0.3),
                          highlightColor: Colors.white.withOpacity(0.15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToAddBlog(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const AddBlogScreen()));
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animationValue;

  WaveClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.7);

    final firstControlPoint = Offset(size.width * 0.25, size.height * (0.7 + 0.1 * animationValue));
    final firstEndPoint = Offset(size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, size.height * (0.7 - 0.1 * animationValue));
    final secondEndPoint = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => true;
}