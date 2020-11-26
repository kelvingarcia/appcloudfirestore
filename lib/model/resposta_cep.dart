class RespostaCep {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ibge;
  final String gia;
  final String ddd;
  final String siafi;

  RespostaCep(this.cep, this.logradouro, this.complemento, this.bairro, this.localidade, this.uf, this.ibge, this.gia, this.ddd, this.siafi);

  RespostaCep.fromJson(Map<String, dynamic> json)
      : cep = json['cep'],
        logradouro = json['logradouro'],
        complemento = json['complemento'],
        bairro = json['bairro'],
        localidade = json['localidade'],
        uf = json['uf'],
        ibge = json['ibge'],
        gia = json['gia'],
        ddd = json['ddd'],
        siafi = json['siafi'];

  @override
  String toString() {
    return 'RespostaCep[cep=$cep, logradouro=$logradouro, complemento=$complemento, bairo=$bairro, localidade=$localidade, uf=$uf]';
  }
}