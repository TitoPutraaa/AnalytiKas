class RiwayatWithDetails {
  final String id;
  final String nama;
  final String tanggal;
  final String status;
  final String keterangan;

  RiwayatWithDetails({
    required this.id,
    required this.nama,
    required this.tanggal,
    required this.status,
    required this.keterangan,
  });

  factory RiwayatWithDetails.fromMap(Map<String, dynamic> map) {
    return RiwayatWithDetails(
      id: map['id'] as String,
      nama: map['nama'] as String,
      tanggal: map['tanggal'] as String,
      status: map['status'] as String,
      keterangan: map['keterangan'] as String,
    );
  }
}
