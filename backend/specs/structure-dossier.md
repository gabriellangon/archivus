Structure de dossier finale, les dossiers seront ajouté au fur et a mesure des besoins, tout ne sera pas ajoutés d'un coup. 
dossier actuel archivus/backend

archivus/
├─ README.md                 # Vision produit, liens rapides, badges CI
├─ .gitignore
├─ .editorconfig
├─ .github/
│  ├─ workflows/             # build-test.yml, docker-push.yml, deploy-dev.yml…
│  └─ ISSUE_TEMPLATE/        # bug.md, feature.md
├─ docs/                     # 📚 Docs vivantes (ADR, C4, guides)
│  ├─ adr/                   # Architecture Decision Records (ADR-001.md…)
│  ├─ c4/                    # draw.io ou Structurizr JSON
│  └─ onboarding.md
├─ scripts/                  # Helpers cross-stack (ex : ./scripts/dev-up.sh)
│  └─ pre-commit             # Hooks qualité code
├─ backend/                  # Spring Boot multi-module Maven
│  ├─ pom.xml                # Parent (Java 21, Spring Boot 3)
│  ├─ api/                   # Module REST controllers + DTO
│  ├─ domain/                # Entités JPA, MapStruct mappers
│  ├─ service/               # Services métier + Kafka producer/consumer
│  ├─ infra/                 # Config DB, S3 client, Security (JWT)
│  ├─ test/                  # Test support utils + TestContainers
│  ├─ resources/
│  │  └─ application.yaml
│  └─ Dockerfile
├─ frontend/                 # Angular 17
│  ├─ angular.json
│  ├─ src/
│  │  ├─ app/
│  │  │  ├─ core/            # Interceptors, auth-guard, services
│  │  │  ├─ features/        # notes/, auth/, search/
│  │  │  └─ shared/          # UI components, pipes
│  │  └─ assets/
│  ├─ cypress/               # E2E smoke tests
│  ├─ jest.config.ts
│  └─ Dockerfile
├─ infra/                    # IaC et déploiement
│  ├─ terraform/
│  │  ├─ modules/            # vpc/, rds/, ecs-fargate/, msk/…
│  │  ├─ envs/
│  │  │  ├─ dev/
│  │  │  └─ prod/
│  ├─ cdk/                   # (optionnel) CDK stacks TypeScript
│  ├─ helm/                  # Chart si passage à EKS
│  └─ diagrams/              # Source .drawio des schémas infra
├─ .devcontainer/            # Config VS Code + Docker Compose (DB, Kafka)
└─ LICENSE
