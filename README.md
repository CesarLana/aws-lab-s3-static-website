# Lab AWS - Hospedagem de Site Estatico no Amazon S3 com AWS CLI

Lab prÃ¡tico â€” Hospedagem de site estÃ¡tico no Amazon S3 com AWS CLI
Escola da Nuvem Â· AWS re/Start

## O que foi feito
- Criado bucket S3 com nome exclusivo
- Configurado como hospedagem de site estÃ¡tico (`index.html`, `error.html`)
- Desbloqueado acesso pÃºblico e configurada Bucket Policy de leitura (`s3:GetObject`)
- Upload e sincronizaÃ§Ã£o dos arquivos do site via AWS CLI
- Script Bash para automaÃ§Ã£o de novos deploys

## Arquitetura

```
Navegador (UsuÃ¡rio)
       â”‚
       â–¼ (HTTP)
Amazon S3 (Bucket com Static Website Hosting)
       â”œâ”€â”€ index.html
       â””â”€â”€ error.html
```

## Passo a passo no Console da AWS

### 1. Criar o bucket S3
1. Acesse o serviÃ§o **S3** no console da AWS
2. Clique em **Criar bucket**
3. Defina um nome globalmente exclusivo (ex: `meu-site-estatico-cesar`)
4. RegiÃ£o: `us-east-1` (Norte da VirgÃ­nia)
5. Clique em **Criar bucket**

### 2. Habilitar a Hospedagem de Site EstÃ¡tico
1. Abra o bucket criado e acesse a aba **Propriedades**
2. Role atÃ© a seÃ§Ã£o **Hospedagem de site estÃ¡tico** e clique em **Editar**
3. Selecione **Ativar**
4. Tipo de hospedagem: **Hospedar um site estÃ¡tico**
5. Documento de Ã­ndice: `index.html`
6. Documento de erro: `error.html`
7. Clique em **Salvar alteraÃ§Ãµes**

### 3. Liberar Acesso PÃºblico
1. Acesse a aba **PermissÃµes** do bucket
2. Em **Bloquear acesso pÃºblico (configuraÃ§Ãµes do bucket)**, clique em **Editar**
3. Desmarque a opÃ§Ã£o **Bloquear todo o acesso pÃºblico**
4. Clique em **Salvar alteraÃ§Ãµes** e confirme digitando `confirmar`

### 4. Configurar a PolÃ­tica do Bucket (Bucket Policy)
1. Ainda na aba **PermissÃµes**, role atÃ© **PolÃ­tica do bucket** e clique em **Editar**
2. Cole a polÃ­tica abaixo (substitua `NOME-DO-SEU-BUCKET` pelo nome real do seu bucket):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::NOME-DO-SEU-BUCKET/*"
    }
  ]
}
```
3. Clique em **Salvar alteraÃ§Ãµes**

### 5. Upload dos Arquivos via AWS CLI
No terminal local (com as credenciais da AWS configuradas):

```bash
# Upload dos arquivos do site
aws s3 sync ./site/ s3://NOME-DO-SEU-BUCKET/
```

### 6. Testar o Site
1. Volte na aba **Propriedades** do bucket
2. Role atÃ© o final em **Hospedagem de site estÃ¡tico**
3. Copie o **Endpoint do site** (ex: `http://meu-site-estatico-cesar.s3-website-us-east-1.amazonaws.com`) e acesse no navegador

---

## AutomaÃ§Ã£o com Script Bash

O script `deploy.sh` permite atualizar o site com um Ãºnico comando:

```bash
bash deploy.sh NOME-DO-SEU-BUCKET
```
