class Company {
  int? id;
  String? cnpj;
  String? legalName;
  String? website;

  Company({
    this.id,
    this.cnpj,
    this.legalName,
    this.website,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      cnpj: json['cnpj'],
      legalName: json['legalName'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cnpj': cnpj,
      'legalName': legalName,
      'website': website,
    };
  }

  String? get cnpjMask {
    if (cnpj == null || cnpj!.isEmpty) {
      return cnpj;
    }

    return _addCnpjMask(cnpj!);
  }

  String _addCnpjMask(String cnpj) {
    return cnpj.replaceAllMapped(RegExp(r'^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$'), (match) {
      return '${match[1]}.${match[2]}.${match[3]}/${match[4]}-${match[5]}';
    });
  }

  String get initials {
    if (legalName == null || legalName!.isEmpty) {
      return 'XX';
    }

    final nomes = legalName!.split(' ');
    if (nomes.length > 1) {
      return '${nomes[0][0]}${nomes[nomes.length - 1][0]}';
    } else if (nomes.isNotEmpty) {
      return '${nomes[0][0]}${nomes[0][1]}';
    }

    return 'XX';
  }
}
