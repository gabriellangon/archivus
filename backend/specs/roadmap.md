### Feuille de route « Archivus » – Apprendre Spring Boot, Angular & la plateforme AWS pas à pas

*(vision “projet d’entreprise” orientée démonstration pour recruteur)*

---

#### ⚙️ Phase 0 – Cadrage & poste de travail (1 jour)

| Livrable                      | Objectifs clés                                                                                                  |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------- |
| **README « vision produit »** | Reformuler les specs en vos mots, décrire les “personas” et la promesse de valeur.                              |
| **Board Kanban GitHub**       | Colonnes : *Backlog*, *En cours*, *Revue*, *Done*.                                                              |
| **Environnement dev**         | Install JDK 21, Docker Desktop, Node LTS, AWS CLI, Terraform/CloudFormation, IDE (IntelliJ + plugins), VS Code. |

> 💡 *Pitch recruteur :* montre dès le premier jour votre capacité à structurer un projet : docs, backlog, outillage.

---

#### 🏗️ Phase 1 – MVP « texte & URL » en local (5 jours)

1. **Monorepo ⇢ modules séparés** (`frontend/`, `backend/`, `infra/`).
2. **Backend Spring Boot (REST)**

   * Bootstrapping : `spring-boot-starter-web`, `spring-boot-starter-data-jpa`, PostgreSQL (+ containers TestContainers pour les tests).
   * Entités : `User`, `Note` *(type TEXT / URL)*.
   * Services + DTO + MapStruct pour le mapping.
   * Tests unitaires (JUnit 5, Mockito).
3. **Frontend Angular**

   * Skeleton SPA : Angular 17, routing, service de communication HTTP.
   * Formulaire simple de création de note, liste paginée.
   * Tests unitaires (Jest) & **Cypress** quick smoke test.
4. **Dockerisation locale**

   * `Dockerfile` multi-stage pour Spring Boot.
   * `docker-compose.yml` : backend, db, pgAdmin, frontend (nginx).

---

#### 🌐 Phase 2 – Authentification & sécurité (3 jours)

1. **Spring Security** – JWT *resource server*.
2. **Angular** – Interceptor pour porter le token.
3. **Gestion des rôles** (`ROLE_USER`, `ROLE_ADMIN`) + guards côté Angular.
4. **Tests d’intégration** (Spring Boot Test + TestContainers) pour les endpoints protégés.

---

#### 📦 Phase 3 – Mise en conteneur & déploiement AWS *“Dev”* (4 jours)

1. **Terraform** ou **AWS CDK**

   * VPC simple, RDS PostgreSQL, S3 public-blocked, ECR, ECS Fargate ou EKS (selon ce que vous voulez explorer).
2. **CI / CD**

   * GitHub Actions : **build-test-push** image ➜ **deploy** (aws deploy action).
3. **CloudFront + S3** pour Angular.
4. **Secrets Manager** : variables DB, JWT secret.

---

#### 🖼️ Phase 4 – Upload & traitement d’images (5 jours)

1. **Endpoint Multipart** Spring Boot ➜ upload direct vers S3 (presigned URL ou proxy).
2. **Fonction Lambda (Python)**

   * Déclenchée par `s3:ObjectCreated`.
   * Appelle **Amazon Rekognition** (*labels*).
   * Publie sur **Kafka** (`image-recognition-results`).
3. **Kafka MSK Dev cluster** + client Spring (`spring-kafka`).
4. **Consumer** Spring → enregistre labels en DB + génère embedding (langchain4j / OpenAI embeddings).
5. **Tests E2E** : push image ➜ récupérer labels stockés.

---

#### 🔍 Phase 5 – Recherche sémantique & OpenSearch (4 jours)

1. **Indexation texte & labels**

   * Mapping vectoriel (KNN) dans OpenSearch 2.13.
2. **Service `SemanticSearchService`** Spring Boot

   * Génération embedding requête utilisateur.
   * Requête KNN ➜ Post-filter DB ➜ DTO résultat.
3. **Interface Angular**

   * Barre de recherche, résultats triés, surlignage mots-clés.
4. **Tests de pertinence** (scripts Jupyter locaux ou Postman).

> 🔬 *Votre histoire* : “J’ai implémenté la recherche vectorielle *explainability-ready*.”

---

#### 📊 Phase 6 – Observabilité & qualité (3 jours)

1. **Micrometer + Prometheus** (ou CloudWatch metrics).
2. **Logs structurés** (JSON + correlationId).
3. **Grafana dashboard** importé.
4. **Alertes** (CloudWatch Alarms ou Grafana Cloud).

---

#### 🚀 Phase 7 – Hardening & mise en prod “demo” (3 jours)

1. **Blue/Green deploy** ECS ou EKS + CodeDeploy.
2. **Tests de charge** : k6 ou Gatling → ajuster *autoscaling* (CPU, mémoire).
3. **Backups RDS, versioning S3, rotation des clés Secrets Manager**.
4. **Politique IAM least-privilege** revue (AWS Access Analyzer).

---

#### 📝 Phase 8 – Documentation & Storytelling (continu, finalisé en 2 jours)

| Support                                     | Contenu                                                              |
| ------------------------------------------- | -------------------------------------------------------------------- |
| **Wiki GitHub**                             | Architecture, choices, README par dossier.                           |
| **Diagrammes C4**                           | Contexte, Conteneurs, Composants (utiliser draw\.io ou Structurizr). || **Journal de bord (blog Medium ou Notion)** | Petits articles « Jour n : ce que j’ai appris ».                     |


## Plus loin

* Ajouter **WebSockets** pour live updates.
* Intégrer **OpenTelemetry** end-to-end.
* Passer à **EKS** & **Argo CD** pour explorer GitOps.
* Support vidéo : transcoding à la volée via AWS Elastic Transcoder + labels Rekognition.

---

**➡️ Prochaine action concrète**
Crée dès maintenant le repository GitHub, pousse le README “vision” et ouvre la première issue *Project setup*. Cela déclenche le voyage ! Bonne construction 🚀
