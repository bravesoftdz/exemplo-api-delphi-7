## Exemplo de uso da API do MeuCrediário com Delphi 7
API do MeuCrediário utiliza o Cloudfront da Amazon AWS, o mesmo utiliza SNI <https://en.wikipedia.org/wiki/Server_Name_Indication>, em virtude disto no Windows XP conexões HTTPS normais acabam dando erro, pois o SNI utiliza TLS 1.2.

Para funcionar com Delphi 7 e no Windows XP é necessário utlizar a última versão do Indy Components <http://www.indyproject.org/Sockets/Docs/Indy10Installation.en.aspx>, esta versão esta compativel com o TLS 1.2.

Após complicado lembrar de colocar junto as DLL's do OpenSSL (ssleay32.dll e libeay32.dll).

### Entre em contato com dev@meucrediário.com.br ou 0800-024-8778 para receber o seu Token de testes.



