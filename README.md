# Azure Infrastructure

<p align="center">
  <img alt="Proxmox" src="./img/architeture.png"
</p>

## Conceitos aplicados

Os seguintes conceitos foram aplicados durante o desenvolvimento desse projeto: 

- Virtualizadores tipo 1 e tipo 2 
  - [VMware Workstation 17](https://www.vmware.com/)
  - [Proxmox VE 8.0](https://www.proxmox.com/en/)
- VMM (Virtual Machine Manager)
- Snapshots
- Máquina Virtual
- CPU Virtual
- Memória Virtual
- Storage NAS
- NFS
- Docker
- GCP Bucket


## Atividades propostas/realizadas

- [x] Nested virtualization (instalar um virtualizador tipo 1 dentro de um virtualizador tipo 2)
- [x] Criação de máquinas virtuais (Debian e TrueNAS)
- [x] Configuração de IP estático para as VMs
- [x] Configuração de rede e subrede do virtualizador.
- [x] Configuração de route/gateway
- [x] Configuração de disco para o storage
- [x] Configuracao de LUN no TrueNAS com iSCSI
- [ ] Migração da máquina virtual para a nuvem (GCP).