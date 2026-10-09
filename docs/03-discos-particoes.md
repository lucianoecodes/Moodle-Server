# 3. Discos e Partições (LVM + XFS)

## Layout de discos

O servidor possui **dois discos virtuais** com gerenciamento de volume **LVM** e sistema de arquivos **XFS**.

### Disco `sda` — 50 GB (Sistema Operacional)

| Partição | Tamanho | Montagem | Sistema de arquivos |
|----------|---------|----------|---------------------|
| `sda1` | 1 GB | `/boot/efi` | vfat |
| `sda2` | 1 GB | `/boot` | xfs |
| `sda3` | 48 GB | LVM (`vg_sistema`) | — |
| ├── root | 44 GB | `/` | xfs |
| └── swap | 4 GB | `swap` | — |

### Disco `sdb` — 100 GB (Dados)

| Partição | Tamanho | Montagem | Sistema de arquivos |
|----------|---------|----------|---------------------|
| `sdb1` | 100 GB | LVM (`vg_dados-var`) | — |
| └── /var | 100 GB | `/var` | xfs |

> O volume `vg_dados-var` é montado em **`/var`**, onde o Docker armazena seus volumes.

## Utilização atual

| Montagem | Ponto | Utilização |
|----------|-------|------------|
| Raiz | `/` | 8% utilizado |
| Dados | `/var` | 6% utilizado |

## Considerações

- A **separação do `/var` em disco dedicado** isola os dados do Docker do sistema operacional.
- Isso evita que o crescimento dos volumes (banco + uploads do Moodle) esgote o disco do sistema.

## Continuar

- [Anterior: Sistema Operacional](02-sistema-operacional.md)
- [Próximo: Hardware e Desempenho](04-hardware.md)
