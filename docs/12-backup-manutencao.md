# 12. Backup e Recomendações de Manutenção

## Itens críticos para backup

| Item crítico | Onde está |
|--------------|-----------|
| Banco de dados MariaDB | Volume `moodle-app_db_data` |
| Código Moodle + `config.php` | Volume `moodle-app_moodle_data` |
| Dados de upload | Volume `moodle-app_moodledata_uploads` |
| Configurações persistentes (cert, vhosts, mods) | Pasta `/var/lib/docker/moodle-app/` |
| Arquivo `docker-compose.yml` | `/var/lib/docker/moodle-app/` |

## Recomendações

- ✅ Realizar **backup do banco** via `mysqldump` periodicamente.
- ✅ **Monitorar a renovação do certificado** (válido até **23/02/2027**) e planejar a troca com antecedência.
- ✅ Acompanhar **atualizações de segurança** do Oracle Linux e das imagens Docker.
- ✅ Manter **backups fora do servidor** (ex.: cópia de `/var/lib/docker/moodle-app/` + dump do banco).
- ✅ Revisar periodicamente:
  - Política de **senhas**;
  - **Idioma padrão** (pt_br);
  - Configuração **LDAP**.

## Exemplo de script de backup

Veja o script sugerido em [`scripts/backup.sh`](../scripts/backup.sh).

## Continuar

- [Anterior: Usuários do Sistema Operacional](11-usuarios-sistema.md)
- [Próximo: Implementação de Novo Servidor](13-implementacao-novo-servidor.md)
