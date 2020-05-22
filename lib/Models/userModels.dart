class User {
  final int id;
  final String nama;
  final String imageUrl;
  final int nisn;
  final String jurusan;
  final String kelas;
  final String gender;
  final String alamat;

  User({
    this.id,
    this.nama,
    this.imageUrl,
    this.nisn,
    this.jurusan,
    this.kelas,
    this.gender,
    this.alamat,
  });
}

final User akun = User(
  id: 0,
  nama: 'Muammar Khadafi',
  imageUrl: 'images/me2.jpg',
  nisn: 123456,
  jurusan: 'Rekayasa Perangkat Lunak',
  kelas: 'IX 1',
  gender: 'L',
  alamat: 'Blang Bintang',
);
final User akun1 = User(
  id: 1,
  nama: 'Muammar Khadafi',
  imageUrl: 'images/me.jpg',
  nisn: 765432,
  jurusan: 'Rekayasa Perangkat Lunak',
  kelas: 'IX 1',
  gender: 'L',
  alamat: 'Blang Bintang',
);

List<User> data = [
  User(
    id: 0,
    nama: 'Muammar Khadafi',
    nisn: 123456,
    jurusan: 'Rekayasa Perangkat Lunak',
    kelas: 'IX 1',
    gender: 'L',
    alamat: 'Blang Bintang',
  ),
  User(
    id: 1,
    nama: 'Muhammad Bayu',
    nisn: 098765,
    jurusan: 'Teknik Jaringan Akses',
    kelas: 'IX 2',
    gender: 'L',
    alamat: 'Lampenurut',
  ),
];

class Month {
  final String nama;
  final bool check;

  Month({
    this.nama,
    this.check,
  });
}

List<Month> dataB = [
  Month(nama: 'January', check: false),
  Month(nama: 'February', check: true),
  Month(nama: 'Maret', check: false),
  Month(nama: 'April', check: true),
  Month(nama: 'May', check: true),
  Month(nama: 'juni', check: false),
  Month(nama: 'Juli', check: true),
  Month(nama: 'Agustus', check: false),
  Month(nama: 'September', check: true),
  Month(nama: 'Oktober', check: false),
  Month(nama: 'November', check: true),
  Month(nama: 'Desember'),
];

class Tagih {
  final String nama;
  final String jumlah;
  final int wajibSemua;
  final int kelas;
  final int forUser;

  Tagih({
    this.nama,
    this.jumlah,
    this.wajibSemua,
    this.kelas,
    this.forUser,
  });
}

List<Tagih> daftarTagih = [
  Tagih(
    nama: 'Spp',
    jumlah: '150000',
    wajibSemua: 1,
  ),
  Tagih(
    nama: 'Pembangunan',
    jumlah: '150000',
    kelas: 2,
  ),
];
