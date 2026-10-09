# 11. Usuários do Sistema Operacional

## Contas locais do SO

| Usuário | UID | Descrição |
|---------|-----|-----------|
| `root` | 0 | Superusuário (acesso SSH) |
| `adminlocal` | 1000 | Usuário administrativo (home `/home/adminlocal`) |

## Notas

- O acesso administrativo ao servidor é feito via **SSH** (porta 22) como `root` ou `adminlocal`.
- As senhas desses usuários são armazenadas como hash em `/etc/shadow` (ver [credenciais](10-credenciais.md)).

## Continuar

- [Anterior: Usuários e Credenciais](10-credenciais.md)
- [Próximo: Backup e Recomendações de Manutenção](12-backup-manutencao.md)
