import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final bool isLoggedIn;
  final VoidCallback? onLogout;

  const SettingsPage({
    super.key,
    this.isLoggedIn = false,
    this.onLogout,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _offlineMode = false;
  double _crossfade = 0;
  bool _gaplessPlayback = true;
  bool _automix = false;
  String _volumeLevel = 'Normal';
  bool _autoplay = true;
  bool _canvas = true;
  String _equalizerPreset = 'Flat';

  bool _privateSession = false;
  bool _listeningActivity = true;
  bool _recentlyPlayedArtists = true;
  String _followersVisibility = 'Public';
  String _playlistVisibility = 'Public';
  bool _playlistsOnProfile = true;

  bool _explicitContent = true;
  bool _showUnplayableSongs = false;
  String _language = 'Bahasa Indonesia';

  bool _carMode = false;
  bool _jamBluetooth = true;
  bool _preciseLocation = false;

  String _wifiQuality = 'Very High';
  String _cellularQuality = 'High';
  String _downloadQuality = 'Very High';
  double _storageUsed = 1.8;
  final double _storageTotal = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Pengaturan & Privasi',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 32),
        children: [
          _sectionTitle('Akun', Icons.person_outline),
          if (widget.isLoggedIn)
            _settingsTile(
              icon: Icons.account_circle_outlined,
              title: 'User Profile',
              subtitle: 'Nama tampilan, foto profil, dan email terdaftar',
              onTap: _showUserProfile,
            ),
          _settingsTile(
            icon: Icons.workspace_premium_outlined,
            title: 'Subscription Plan',
            subtitle: widget.isLoggedIn
                ? 'Premium Individual • Perpanjangan 27 Oktober 2026'
                : 'Belum login • Masuk untuk melihat paket',
            enabled: widget.isLoggedIn,
            onTap: widget.isLoggedIn ? _showSubscription : null,
          ),

          _sectionTitle('Pemutaran', Icons.play_circle_outline),
          _switchTile(
            icon: Icons.cloud_off_outlined,
            title: 'Offline Mode',
            subtitle: 'Hanya putar lagu atau podcast yang sudah diunduh',
            value: _offlineMode,
            onChanged: (value) => setState(() => _offlineMode = value),
          ),
          _sliderTile(
            icon: Icons.compare_arrows_outlined,
            title: 'Crossfade',
            subtitle: 'Transisi antar-lagu tanpa jeda hening',
            value: _crossfade,
            min: 0,
            max: 12,
            divisions: 12,
            valueLabel: '${_crossfade.round()} detik',
            onChanged: (value) => setState(() => _crossfade = value),
          ),
          _switchTile(
            icon: Icons.all_inclusive,
            title: 'Gapless Playback',
            subtitle: 'Hilangkan jeda kosong di antara trek',
            value: _gaplessPlayback,
            onChanged: (value) => setState(() => _gaplessPlayback = value),
          ),
          _switchTile(
            icon: Icons.auto_awesome_outlined,
            title: 'Automix',
            subtitle: 'Buat transisi fading dan mixing pada playlist yang mendukung',
            value: _automix,
            onChanged: (value) => setState(() => _automix = value),
          ),
          _choiceTile(
            icon: Icons.volume_up_outlined,
            title: 'Volume Level',
            subtitle: 'Normalisasi volume global',
            value: _volumeLevel,
            options: const ['Loud', 'Normal', 'Quiet'],
            onChanged: (value) => setState(() => _volumeLevel = value),
          ),
          _switchTile(
            icon: Icons.queue_music_outlined,
            title: 'Autoplay',
            subtitle: 'Lanjutkan dengan lagu rekomendasi setelah selesai',
            value: _autoplay,
            onChanged: (value) => setState(() => _autoplay = value),
          ),
          _switchTile(
            icon: Icons.ondemand_video_outlined,
            title: 'Canvas',
            subtitle: 'Tampilkan video pendek looping di layar pemutar',
            value: _canvas,
            onChanged: (value) => setState(() => _canvas = value),
          ),
          _settingsTile(
            icon: Icons.equalizer,
            title: 'Equalizer',
            subtitle: 'Preset: $_equalizerPreset',
            onTap: _showEqualizer,
          ),

          _sectionTitle('Privasi & Sosial', Icons.lock_outline),
          _switchTile(
            icon: Icons.visibility_off_outlined,
            title: 'Private Session',
            subtitle: 'Sembunyikan aktivitas mendengarkan dari pengikut',
            value: _privateSession,
            onChanged: (value) => setState(() => _privateSession = value),
          ),
          _switchTile(
            icon: Icons.people_outline,
            title: 'Listening Activity',
            subtitle: 'Bagikan musik yang sedang diputar ke Friend Activity',
            value: _listeningActivity,
            onChanged: (value) => setState(() => _listeningActivity = value),
          ),
          _switchTile(
            icon: Icons.person_search_outlined,
            title: 'Recently Played Artists',
            subtitle: 'Tampilkan artis yang baru didengarkan di profil',
            value: _recentlyPlayedArtists,
            onChanged: (value) => setState(() => _recentlyPlayedArtists = value),
          ),
          _choiceTile(
            icon: Icons.group_outlined,
            title: 'Followers & Following',
            subtitle: 'Visibilitas daftar pengikut dan akun yang diikuti',
            value: _followersVisibility,
            options: const ['Public', 'Private'],
            onChanged: (value) => setState(() => _followersVisibility = value),
          ),
          _choiceTile(
            icon: Icons.playlist_play_outlined,
            title: 'Playlist Visibility',
            subtitle: 'Status default playlist baru',
            value: _playlistVisibility,
            options: const ['Public', 'Private'],
            onChanged: (value) => setState(() => _playlistVisibility = value),
          ),
          _switchTile(
            icon: Icons.person_pin_outlined,
            title: 'Playlists appear on your profile',
            subtitle: 'Pajang playlist baru secara otomatis di profil',
            value: _playlistsOnProfile,
            onChanged: (value) => setState(() => _playlistsOnProfile = value),
          ),
          _settingsTile(
            icon: Icons.block_outlined,
            title: 'Blocked Users',
            subtitle: 'Kelola akun yang telah Anda blokir',
            onTap: _showBlockedUsers,
          ),

          _sectionTitle('Konten & Tampilan', Icons.palette_outlined),
          _switchTile(
            icon: Icons.explicit_outlined,
            title: 'Explicit Content',
            subtitle: 'Izinkan lagu berlabel E',
            value: _explicitContent,
            onChanged: (value) => setState(() => _explicitContent = value),
          ),
          _switchTile(
            icon: Icons.hide_source_outlined,
            title: 'Show Unplayable Songs',
            subtitle: 'Tampilkan lagu yang tidak tersedia di wilayah Anda',
            value: _showUnplayableSongs,
            onChanged: (value) => setState(() => _showUnplayableSongs = value),
          ),
          _choiceTile(
            icon: Icons.language_outlined,
            title: 'Languages',
            subtitle: 'Bahasa tampilan aplikasi',
            value: _language,
            options: const ['Bahasa Indonesia', 'English'],
            onChanged: (value) => setState(() => _language = value),
          ),

          _sectionTitle('Koneksi Perangkat & Izin', Icons.devices_outlined),
          _settingsTile(
            icon: Icons.cast_connected_outlined,
            title: 'Connect to a Device',
            subtitle: 'Kelola perangkat Spotify Connect di jaringan Anda',
            onTap: _showDevices,
          ),
          _switchTile(
            icon: Icons.directions_car_outlined,
            title: 'Spotify in the Car',
            subtitle: 'Deteksi koneksi Bluetooth mobil secara otomatis',
            value: _carMode,
            onChanged: (value) => setState(() => _carMode = value),
          ),
          _switchTile(
            icon: Icons.bluetooth_outlined,
            title: 'Jam access with Bluetooth',
            subtitle: 'Gunakan Bluetooth untuk mendeteksi perangkat sekitar',
            value: _jamBluetooth,
            onChanged: (value) => setState(() => _jamBluetooth = value),
          ),
          _settingsTile(
            icon: Icons.my_location_outlined,
            title: 'Precise Location',
            subtitle: _preciseLocation
                ? 'Lokasi akurat diizinkan'
                : 'Lokasi akurat tidak digunakan',
            trailing: Switch.adaptive(
              value: _preciseLocation,
              onChanged: (value) => setState(() => _preciseLocation = value),
            ),
            onTap: _showLocation,
          ),

          _sectionTitle('Data Saving & Storage', Icons.storage_outlined),
          _choiceTile(
            icon: Icons.wifi_outlined,
            title: 'Audio Quality • Wi-Fi',
            subtitle: 'Kualitas streaming saat terhubung Wi-Fi',
            value: _wifiQuality,
            options: const ['Low', 'Normal', 'High', 'Very High'],
            onChanged: (value) => setState(() => _wifiQuality = value),
          ),
          _choiceTile(
            icon: Icons.network_cell_outlined,
            title: 'Audio Quality • Cellular',
            subtitle: 'Kualitas streaming saat memakai data seluler',
            value: _cellularQuality,
            options: const ['Low', 'Normal', 'High', 'Very High'],
            onChanged: (value) => setState(() => _cellularQuality = value),
          ),
          _choiceTile(
            icon: Icons.download_outlined,
            title: 'Download Quality',
            subtitle: 'Kualitas lagu yang akan diunduh',
            value: _downloadQuality,
            options: const ['Low', 'Normal', 'High', 'Very High'],
            onChanged: (value) => setState(() => _downloadQuality = value),
          ),
          _storageTile(),

          const SizedBox(height: 24),
          const Divider(color: Color(0xFF2A2A2A)),
          const SizedBox(height: 8),
          _settingsTile(
            icon: Icons.logout,
            title: 'Log Out',
            subtitle: widget.isLoggedIn
                ? 'Keluar dari akun Spotify di perangkat ini'
                : 'Belum ada akun yang login',
            iconColor: widget.isLoggedIn ? Colors.redAccent : Colors.grey,
            titleColor: widget.isLoggedIn ? Colors.redAccent : Colors.grey,
            enabled: widget.isLoggedIn,
            onTap: widget.isLoggedIn ? _confirmLogout : null,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 24, 4, 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1DB954), size: 19),
          const SizedBox(width: 9),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    bool enabled = true,
    Color iconColor = const Color(0xFFB3B3B3),
    Color titleColor = Colors.white,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        enabled: enabled,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
        leading: Icon(icon, color: enabled ? iconColor : Colors.grey, size: 24),
        title: Text(
          title,
          style: TextStyle(
            color: enabled ? titleColor : Colors.grey,
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: enabled ? const Color(0xFF909090) : const Color(0xFF5F5F5F),
            fontSize: 12,
            height: 1.3,
          ),
        ),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: Color(0xFF666666)),
        onTap: onTap,
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return _settingsTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      trailing: Switch.adaptive(value: value, onChanged: onChanged),
    );
  }

  Widget _sliderTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String valueLabel,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.fromLTRB(14, 8, 10, 6),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFB3B3B3), size: 24),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(color: Color(0xFF909090), fontSize: 12, height: 1.25)),
                  ],
                ),
              ),
              Text(valueLabel, style: const TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.w700)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: valueLabel,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _choiceTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return _settingsTile(
      icon: icon,
      title: title,
      subtitle: '$subtitle • $value',
      trailing: const Icon(Icons.chevron_right, color: Color(0xFF666666)),
      onTap: () => _showChoiceDialog(
        title: title,
        options: options,
        selected: value,
        onSelected: onChanged,
      ),
    );
  }

  Widget _storageTile() {
    final ratio = (_storageUsed / _storageTotal).clamp(0.0, 1.0);
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.sd_storage_outlined, color: Color(0xFFB3B3B3)),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'Storage Management',
                  style: TextStyle(color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                '${_storageUsed.toStringAsFixed(1)} GB / ${_storageTotal.toStringAsFixed(1)} GB',
                style: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 7,
              backgroundColor: const Color(0xFF303030),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Hapus cache untuk membersihkan berkas sementara tanpa menghapus lagu yang sudah diunduh.',
            style: TextStyle(color: Color(0xFF909090), fontSize: 12, height: 1.35),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _clearCache,
              child: const Text(
                'CLEAR CACHE',
                style: TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChoiceDialog({
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF242424),
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
                child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
              ),
              ...options.map(
                (option) => RadioListTile<String>(
                  value: option,
                  groupValue: selected,
                  activeColor: const Color(0xFF1DB954),
                  onChanged: (value) {
                    if (value == null) return;
                    onSelected(value);
                    Navigator.pop(context);
                  },
                  title: Text(option, style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUserProfile() {
    showDialog<void>(
      context: context,
      builder: (context) => _dialog(
        title: 'User Profile',
        children: const [
          ListTile(leading: Icon(Icons.person, color: Colors.white), title: Text('Nama Tampilan', style: TextStyle(color: Colors.white)), subtitle: Text('Spotify User', style: TextStyle(color: Colors.grey))),
          ListTile(leading: Icon(Icons.email_outlined, color: Colors.white), title: Text('Email', style: TextStyle(color: Colors.white)), subtitle: Text('user@example.com', style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }

  void _showSubscription() {
    showDialog<void>(
      context: context,
      builder: (context) => _dialog(
        title: 'Subscription Plan',
        children: const [
          ListTile(leading: Icon(Icons.workspace_premium, color: Color(0xFF1DB954)), title: Text('Premium Individual', style: TextStyle(color: Colors.white)), subtitle: Text('Perpanjangan berikutnya: 27 Oktober 2026', style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }

  void _showEqualizer() {
    _showChoiceDialog(
      title: 'Equalizer Preset',
      options: const ['Flat', 'Rock', 'Pop', 'Jazz', 'Bass Boost', 'Treble Boost'],
      selected: _equalizerPreset,
      onSelected: (value) => setState(() => _equalizerPreset = value),
    );
  }

  void _showBlockedUsers() {
    showDialog<void>(
      context: context,
      builder: (context) => _dialog(
        title: 'Blocked Users',
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(18, 4, 18, 16),
            child: Text(
              'Belum ada pengguna yang diblokir.',
              style: TextStyle(color: Color(0xFFB3B3B3), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  void _showDevices() {
    showDialog<void>(
      context: context,
      builder: (context) => _dialog(
        title: 'Connect to a Device',
        children: const [
          ListTile(leading: Icon(Icons.phone_android, color: Color(0xFF1DB954)), title: Text('This Phone', style: TextStyle(color: Colors.white)), subtitle: Text('Perangkat saat ini', style: TextStyle(color: Colors.grey))),
          ListTile(leading: Icon(Icons.tv_outlined, color: Colors.white), title: Text('Tidak ada perangkat lain', style: TextStyle(color: Colors.white)), subtitle: Text('Pastikan perangkat berada di jaringan Wi-Fi yang sama', style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }

  void _showLocation() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF242424),
        title: const Text('Precise Location', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Gunakan kontrol ini sebagai simulasi izin lokasi akurat untuk personalisasi fitur berbasis wilayah.',
          style: TextStyle(color: Color(0xFFB3B3B3), height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _preciseLocation = false);
              Navigator.pop(context);
              ScaffoldMessenger.of(this.context).showSnackBar(
                const SnackBar(content: Text('Data lokasi akurat dihapus dari simulasi pengaturan.')),
              );
            },
            child: const Text('Hapus Data Lokasi', style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup', style: TextStyle(color: Color(0xFF1DB954))),
          ),
        ],
      ),
    );
  }

  void _clearCache() {
    setState(() => _storageUsed = 1.2);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cache berhasil dibersihkan.')),
    );
  }

  void _confirmLogout() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF242424),
        title: const Text('Log Out?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Anda akan keluar dari akun Spotify di perangkat ini.',
          style: TextStyle(color: Color(0xFFB3B3B3)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onLogout?.call();
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  AlertDialog _dialog({required String title, required List<Widget> children}) {
    return AlertDialog(
      backgroundColor: const Color(0xFF242424),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: children)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup', style: TextStyle(color: Color(0xFF1DB954))),
        ),
      ],
    );
  }
}
