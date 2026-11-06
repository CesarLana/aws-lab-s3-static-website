# Lab AWS — Hospedagem de Site Estático no Amazon S3 com AWS CLI

Lab prático — Hospedagem de site estático no Amazon S3 com AWS CLI  
Escola da Nuvem · AWS re/Start

---

## 📌 O que foi feito
- Criação de bucket Amazon S3 com nome globalmente exclusivo
- Habilitação do recurso de Hospedagem de Site Estático (`index.html` e `error.html`)
- Desbloqueio do acesso público e configuração de **Bucket Policy** permissiva para leitura (`s3:GetObject`)
- Upload e sincronização dos arquivos estáticos via **AWS CLI v2**
- Criação de script Bash para automação de futuros deploys

---

## 🏛️ Arquitetura

```
Navegador do Usuário
       │
       ▼ (Requisição HTTP)
Amazon S3 (Bucket com Static Website Hosting)
       ├── index.html (Página Principal)
       └── error.html (Página de Erro 404)
```

---

## 🛠️ Passo a passo no Console da AWS

### 1. Criar o Bucket S3
1. Acesse o serviço **S3** no Console da AWS
2. Clique em **Criar bucket**
3. Defina um nome globalmente exclusivo (ex: `meu-site-estatico-cesar`)
4. Região: selecione `us-east-1` (Norte da Virgínia)
5. Clique em **Criar bucket**

---

### 2. Ativar a Hospedagem de Site Estático
1. Abra o bucket criado e acesse a aba **Propriedades**
2. Role até a seção **Hospedagem de site estático** e clique em **Editar**
3. Selecione **Ativar**
4. Tipo de hospedagem: **Hospedar um site estático**
5. Documento de índice: `index.html`
6. Documento de erro: `error.html`
7. Clique em **Salvar alterações**

---

### 3. Desbloquear o Acesso Público
1. Acesse a aba **Permissões** do bucket
2. Na seção **Bloquear acesso público (configurações do bucket)**, clique em **Editar**
3. Desmarque a opção **Bloquear todo o acesso público**
4. Clique em **Salvar alterações** e confirme digitando `confirmar`

---

### 4. Configurar a Política do Bucket (Bucket Policy)
1. Ainda na aba **Permissões**, role até **Política do bucket** e clique em **Editar**
2. Cole a política abaixo (substitua `SEU-BUCKET` pelo nome real do seu bucket):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::SEU-BUCKET/*"
    }
  ]
}
```
3. Clique em **Salvar alterações**

---

### 5. Upload dos Arquivos via AWS CLI
No terminal local com as credenciais AWS configuradas:

```bash
# Upload dos arquivos locais para o S3
aws s3 sync ./site/ s3://SEU-BUCKET/
```

---

### 6. Testar o Acesso
1. Acesse a aba **Propriedades** do bucket
2. Role até o final na seção **Hospedagem de site estático**
3. Clique no link do **Endpoint do site** para visualizar a página online

---

## 🚀 Script de Deploy Automático (deploy.sh)

Para atualizar o site com um único comando:

```bash
bash deploy.sh SEU-BUCKET
```
