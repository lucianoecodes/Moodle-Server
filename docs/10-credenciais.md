# 10. Usuários e Credenciais ⚠️

> ## 🛑 ATENÇÃO
>
> Este documento contém **credenciais em texto claro**. Manuseio **restrito**.
> **Mantenha este repositório PRIVADO.**

A senha padrão padronizada para todos os serviços é:

```
123SenhaLocal$
```

## Tabela de credenciais

| Serviço | Caminho do arquivo | Usuário | Senha |
|---------|--------------------|---------|-------|
| MySQL/MariaDB (root) | `/var/lib/docker/moodle-app/docker-compose.yml` | `root` | `123SenhaLocal$` |
| MySQL/MariaDB (moodle) | `/var/lib/docker/moodle-app/docker-compose.yml` | `moodle_user` | `123SenhaLocal$` |
| Config PHP Moodle | `/var/www/html/config.php` (no container) | `moodle_user` | `123SenhaLocal$` |
| Admin do Moodle | Banco de dados (`mdl_user`) | `admin` | `123SenhaLocal$` |
| SSH / Root (SO) | `/etc/shadow` (hash) | `root` | `123SenhaLocal$` |
| Usuário SO | `/etc/shadow` (hash) | `adminlocal` | `123SenhaLocal$` |

## Nota

- A senha `123SenhaLocal$` foi adotada como **padrão padronizado** para todos os serviços por decisão do projeto, aparecendo em **texto claro** para facilitar a administração.
- 🔐 Recomenda-se **rotacionar** as senhas de serviços críticos (especialmente `root` do SO e administrador do Moodle) sempre que este repositório for acessado por novas pessoas ou compartilhado.

## Continuar

- [Anterior: Banco de Dados](09-banco-dados.md)
- [Próximo: Usuários do Sistema Operacional](11-usuarios-sistema.md)
