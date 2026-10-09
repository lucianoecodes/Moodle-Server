# 4. Hardware e Desempenho

## Recursos da VM

| Item | Valor |
|------|-------|
| **CPU** | 1 vCPU Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz |
| **Memória RAM** | 7.3 GB (compartilhada + cache) |
| **Swap** | 4 GB |

## Notas de desempenho

- A VM foi provisionada com perfil enxuto (**1 vCPU**), suficiente para o cenário atual de treinamento (Security Awareness).
- As **imagens Docker** (`elestio/moodle` + `mariadb`) têm exigências moderadas de memória; com 7.3 GB + 4 GB de swap há folga para operação.
- Em caso de aumento de concorrência de usuários, considere escalar para **2 vCPU** e **16 GB de RAM**.

## Continuar

- [Anterior: Discos e Partições](03-discos-particoes.md)
- [Próximo: Rede](05-rede.md)
