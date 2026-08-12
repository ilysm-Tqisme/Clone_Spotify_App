import 'package:flutter/material.dart';

class ArtistRegister extends StatefulWidget {
  const ArtistRegister({super.key});

  @override
  State<ArtistRegister> createState() => _ArtistRegisterState();
}

class _ArtistRegisterState extends State<ArtistRegister> {
  final TextEditingController _searchController = TextEditingController();

  final List<Artist> _artists = [
    Artist(
      name: 'Billie Eilish',
      image: 'lib/assets/artists/billie_eilish.jpg',
    ),
    Artist(name: 'Kanye West', image: 'lib/assets/artists/kanye_west.jpg'),
    Artist(
      name: 'Ariana Grande',
      image: 'lib/assets/artists/ariana_grande.jpg',
    ),
    Artist(name: 'Lana Del Rey', image: 'lib/assets/artists/lana_del_rey.jpg'),
    Artist(name: 'BTS', image: 'lib/assets/artists/bts.jpg'),
    Artist(name: 'Drake', image: 'lib/assets/artists/drake.jpg'),
    Artist(name: 'Harry Styles', image: 'lib/assets/artists/harry_styles.jpg'),
    Artist(
      name: 'One Direction',
      image: 'lib/assets/artists/one_direction.jpg',
    ),
    Artist(name: 'Rihanna', image: 'lib/assets/artists/rihanna.jpg'),
    Artist(name: 'Ed Sheeran', image: 'lib/assets/artists/ed_sheeran.jpg'),
    Artist(name: 'The Weeknd', image: 'lib/assets/artists/the_weeknd.jpg'),
    Artist(name: 'Dua Lipa', image: 'lib/assets/artists/dua_lipa.jpg'),
    Artist(name: 'Taylor Swift', image: 'lib/assets/artists/taylor_swift.jpg'),
    Artist(name: 'Bruno Mars', image: 'lib/assets/artists/bruno_mars.jpg'),
    Artist(
      name: 'Justin Bieber',
      image: 'lib/assets/artists/justin_bieber.jpg',
    ),
    Artist(
      name: 'Sabrina Carpenter',
      image: 'lib/assets/artists/sabrina_carpenter.jpg',
    ),
    Artist(name: 'Lady Gaga', image: 'lib/assets/artists/lady_gaga.jpg'),
    Artist(name: 'SZA', image: 'lib/assets/artists/sza.jpg'),
  ];

  final Set<String> _selectedArtists = {};

  String _searchText = '';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Artist> get _filteredArtists {
    if (_searchText.trim().isEmpty) {
      return _artists;
    }

    return _artists.where((artist) {
      return artist.name.toLowerCase().contains(_searchText);
    }).toList();
  }

  void _toggleArtist(String name) {
    setState(() {
      if (_selectedArtists.contains(name)) {
        _selectedArtists.remove(name);
      } else {
        _selectedArtists.add(name);
      }
    });
  }

  void _next() {
    if (_selectedArtists.length < 3) return;

    debugPrint('Selected artists: ${_selectedArtists.join(', ')}');

    // TODO:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const HomeScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final bool canContinue = _selectedArtists.length >= 3;

    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1D),

      body: SafeArea(
        child: Column(
          children: [
            // ============================================================
            // HEADER
            // ============================================================
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 16, right: 16),

              child: Row(
                children: [
                  // ======================================================
                  // BACK BUTTON
                  // ======================================================
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },

                    child: Container(
                      width: 20,
                      height: 20,

                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),

                      child: const Center(
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  // ======================================================
                  // TITLE
                  // ======================================================
                  const Expanded(
                    child: Text(
                      'Choose 3 or more artists you like.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ============================================================
            // MAIN CONTAINER
            // ============================================================
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),

                width: double.infinity,

                color: const Color(0xFF111111),

                child: Column(
                  children: [
                    // ====================================================
                    // SEARCH
                    // ====================================================
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 14,
                        bottom: 10,
                      ),

                      child: SizedBox(
                        height: 27,

                        child: TextField(
                          controller: _searchController,

                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                          ),

                          cursorColor: Colors.black,

                          decoration: InputDecoration(
                            filled: true,

                            fillColor: const Color(0xFFF1F1F1),

                            hintText: 'Search',

                            hintStyle: const TextStyle(
                              color: Color(0xFF555555),
                              fontSize: 9,
                            ),

                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color(0xFF555555),
                              size: 14,
                            ),

                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 28,
                              minHeight: 27,
                            ),

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),

                              borderSide: BorderSide.none,
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),

                              borderSide: BorderSide.none,
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),

                              borderSide: BorderSide.none,
                            ),

                            suffixIcon: _searchText.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 13,
                                      color: Colors.black54,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),

                    // ====================================================
                    // SELECTED COUNT
                    // ====================================================
                    if (_selectedArtists.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 4,
                        ),

                        child: Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            '${_selectedArtists.length} selected',
                            style: const TextStyle(
                              color: Color(0xFF858585),
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),

                    // ====================================================
                    // ARTIST GRID
                    // ====================================================
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),

                        physics: const BouncingScrollPhysics(),

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,

                              crossAxisSpacing: 8,

                              mainAxisSpacing: 12,

                              childAspectRatio: 0.78,
                            ),

                        itemCount: _filteredArtists.length,

                        itemBuilder: (context, index) {
                          final artist = _filteredArtists[index];

                          final isSelected = _selectedArtists.contains(
                            artist.name,
                          );

                          return _artistItem(artist, isSelected);
                        },
                      ),
                    ),

                    // ====================================================
                    // NEXT BUTTON
                    // ====================================================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),

                      child: SizedBox(
                        height: 22,

                        child: ElevatedButton(
                          onPressed: canContinue ? _next : null,

                          style: ElevatedButton.styleFrom(
                            elevation: 0,

                            padding: const EdgeInsets.symmetric(horizontal: 18),

                            backgroundColor: canContinue
                                ? const Color(0xFF686868)
                                : const Color(0xFF5A5A5A),

                            disabledBackgroundColor: const Color(0xFF5A5A5A),

                            foregroundColor: Colors.black,

                            disabledForegroundColor: const Color(0xFF1A1A1A),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),

                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ARTIST ITEM
  // ============================================================
  Widget _artistItem(Artist artist, bool isSelected) {
    return GestureDetector(
      onTap: () {
        _toggleArtist(artist.name);
      },

      child: Column(
        children: [
          // ==========================================================
          // ARTIST IMAGE
          // ==========================================================
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,

                  alignment: Alignment.center,

                  child: Container(
                    width: 76,
                    height: 76,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      border: isSelected
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),

                    child: ClipOval(
                      child: Image.asset(
                        artist.image,

                        width: 76,
                        height: 76,

                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF242424),

                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF666666),
                              size: 35,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // ======================================================
                // SELECT CHECK
                // ======================================================
                if (isSelected)
                  Positioned(
                    right: 10,
                    top: 0,

                    child: Container(
                      width: 18,
                      height: 18,

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.check,
                        color: Colors.black,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          // ==========================================================
          // ARTIST NAME
          // ==========================================================
          SizedBox(
            height: 15,

            child: Text(
              artist.name,

              textAlign: TextAlign.center,

              maxLines: 1,

              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFFE0E0E0),

                fontSize: 7,

                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ARTIST MODEL
// ============================================================================

class Artist {
  final String name;
  final String image;

  const Artist({required this.name, required this.image});
}
