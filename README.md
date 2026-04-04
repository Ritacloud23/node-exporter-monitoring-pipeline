#  End-to-End DevOps Pipeline Project

A full-stack DevOps and Cloud Engineering project that demonstrates how to provision infrastructure, automate CI/CD, deploy an application to Kubernetes, and implement monitoring with Prometheus and Grafana.

---

##  Project Overview

This project was built step-by-step as a real DevOps workflow rather than a one-time setup.

It started with infrastructure provisioning using Terraform, moved into Jenkins-based CI/CD preparation, continued with Kubernetes deployment using Minikube, and then advanced into monitoring and observability with Prometheus and Grafana.

Throughout the project, I worked through real engineering issues such as local cluster reset, manifest validation, image pull delays, Grafana instability, probe failures, and Prometheus target troubleshooting.

This project demonstrates practical DevOps and Cloud practices including:

- Infrastructure as Code with Terraform
- CI/CD foundation with Jenkins
- Kubernetes deployment and validation
- Local cluster management with Minikube
- Monitoring and observability with Prometheus and Grafana
- Real-world troubleshooting and recovery

---
## ⚙️ Technologies Used

### Core
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

---

### CI/CD
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)

---

### Containers & Infrastructure

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)

---

### Cloud
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
---


##  Project Breakdown (Step-by-Step)

### 1) Project Setup

The project started with organizing the repository structure and preparing folders for the application, Kubernetes manifests, monitoring configuration, Jenkins pipeline files, and Terraform files.

#### What I did

- Organized the project folders
- Prepared frontend and backend directories
- Structured Kubernetes manifest files
- Added monitoring and Jenkins-related files
- Prepared the repository for deployment and automation work

---

### 2) Infrastructure Provisioning with Terraform

Terraform was used to provision the cloud infrastructure needed for the Jenkins setup.

#### What was provisioned

- EC2 instance
- Security group configuration
- Elastic IP
- Supporting Terraform state and outputs

#### Commands used

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

#### What this phase demonstrated

- Infrastructure as Code
- Cloud resource provisioning
- Repeatable environment setup
- Terraform workflow from initialization to apply

---

### 3) Jenkins Setup and CI/CD Preparation

After provisioning the infrastructure, Jenkins was set up as the CI/CD tool to validate the project structure and prepare for automation.

#### What I did

- Accessed the Jenkins server
- Worked with the Jenkins pipeline file
- Structured validation stages
- Confirmed Jenkins could inspect project directories and files

#### Areas validated

- `frontend/`
- `backend/`
- `k8s/`
- `monitoring/`
- `jenkins/`

#### CI/CD focus

- Source checkout
- File visibility
- Project structure validation
- Deployment preparation

---

### 4) Application and File Validation

Before deploying to Kubernetes, I validated the project files and folder structure locally.

#### Commands used

```bash
ls -la
ls -la frontend
ls -la backend
ls -la k8s
ls -la monitoring
ls -la jenkins
```

#### What this phase demonstrated

- Repository structure validation
- Deployment file readiness
- Confidence before Kubernetes deployment

---

### 5) Minikube Reset and Cluster Recreation

During the Kubernetes setup process, the local Minikube environment developed issues and had to be reset completely.

#### Issues encountered

- Minikube deletion initially failed
- Locked file issue on Windows
- Local cluster instability
- Need for a clean cluster rebuild

#### Recovery process

```bash
minikube stop
minikube delete
minikube start --driver=docker
kubectl get nodes
kubectl get pods -A
```

#### What this phase demonstrated

- Cluster recovery
- Local Kubernetes reset
- Troubleshooting environment corruption
- Rebuilding a clean Kubernetes environment

---

### 6) Kubernetes Deployment

After recreating the cluster, I reapplied the Kubernetes manifests for the application.

#### Components deployed

- Backend deployment
- Backend service
- Frontend deployment
- Frontend service

#### Commands used

```bash
kubectl apply -f k8s/backend-deployment.yaml
kubectl apply -f k8s/backend-service.yaml
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml
```

#### Validation commands

```bash
kubectl get pods
kubectl get svc
kubectl apply --dry-run=client -f k8s/backend-deployment.yaml
kubectl apply --dry-run=client -f k8s/backend-service.yaml
kubectl apply --dry-run=client -f k8s/frontend-deployment.yaml
kubectl apply --dry-run=client -f k8s/frontend-service.yaml
```

#### What this phase demonstrated

- Kubernetes manifest deployment
- Service and pod validation
- Safe testing using dry-run before full application

---

### 7) Monitoring Setup with Prometheus and Grafana

The monitoring phase focused on implementing observability for the local Kubernetes environment.

#### Objectives

- Deploy Prometheus
- Deploy Grafana
- Validate target scraping
- Build a monitoring workflow around the application and cluster

#### Helm commands used

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring --create-namespace
```

#### Access commands used

```bash
kubectl port-forward svc/monitoring-kube-prometheus-prometheus -n monitoring 9090:9090
kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80
```

---

### 8) Monitoring Troubleshooting and Stabilization

This became one of the most important parts of the project because it involved real troubleshooting.

#### Issues encountered

- TLS handshake timeout while pulling images
- Prometheus connection interruptions
- Grafana target showing `DOWN`
- `CrashLoopBackOff` on Grafana
- Readiness and liveness probe failures
- Local port-forward instability
- `Metrics API not available`
- `connection refused` errors from Grafana health checks

#### Commands used during troubleshooting

```bash
kubectl get pods -n monitoring
kubectl get svc -n monitoring
kubectl describe pod monitoring-grafana-757d5bf877-n45sz -n monitoring
kubectl logs monitoring-grafana-757d5bf877-n45sz -n monitoring --all-containers=true
kubectl logs monitoring-grafana-757d5bf877-n45sz -n monitoring -c grafana --previous
kubectl get pod monitoring-grafana-757d5bf877-n45sz -n monitoring -o jsonpath="{.spec.containers[*].name}"
kubectl edit deployment monitoring-grafana -n monitoring
```

#### Root cause identified

Grafana was not getting enough time to become healthy before Kubernetes ran its probes. This caused repeated restart loops and prevented Prometheus from scraping it successfully.

#### Fix applied

I tuned the Grafana health probes to give the container more startup time.

#### Probe adjustment

```yaml
livenessProbe:
  failureThreshold: 10
  httpGet:
    path: /api/health
    port: grafana
    scheme: HTTP
  initialDelaySeconds: 120
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 30

readinessProbe:
  failureThreshold: 10
  httpGet:
    path: /api/health
    port: grafana
    scheme: HTTP
  initialDelaySeconds: 60
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 5
```

#### Outcome after the fix

- Grafana became stable
- Prometheus was able to scrape Grafana successfully
- Targets changed to `UP`
- Monitoring stack became healthy enough for validation

---

## 📂 Project Structure

```bash
terraform-jenkins-project/
├── backend/
├── frontend/
├── jenkins/
├── k8s/
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── frontend-deployment.yaml
│   └── frontend-service.yaml
├── monitoring/
├── Jenkinsfile
├── main.tf
├── outputs.tf
├── provider.tf
├── Security Group.tf
├── Elastic IP.tf
└── README.md
```

---

## ⚡ Getting Started

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd terraform-jenkins-project
```

### 2. Initialize Terraform

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### 3. Start or recreate Minikube

```bash
minikube start --driver=docker
kubectl get nodes
kubectl get pods -A
```

### 4. Deploy the application to Kubernetes

```bash
kubectl apply -f k8s/backend-deployment.yaml
kubectl apply -f k8s/backend-service.yaml
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml
```

### 5. Deploy monitoring stack

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring --create-namespace
```

### 6. Access Prometheus and Grafana

```bash
kubectl port-forward svc/monitoring-kube-prometheus-prometheus -n monitoring 9090:9090
kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80
```

---

## 📸 Screenshots / Demo

- Terraform apply output
- Jenkins pipeline stages
- Minikube running cluster
- Kubernetes pods and services
- Prometheus targets showing `UP`
- Grafana dashboard
- Final project validation

---

## 🧠 Key Lessons Learned

This project reinforced several important DevOps lessons:

- Local environments can behave very differently from cloud environments
- Kubernetes health probes must match actual application startup behavior
- Monitoring stacks need patience, tuning, and validation
- Real DevOps engineering includes troubleshooting, not just deployment
- A successful project is not only about building, but also about recovering from failure cleanly

---

## 🧹 Clean Up

After completing the infrastructure phase, I destroyed the Terraform-managed resources to avoid unnecessary cost.

```bash
terraform destroy -auto-approve
```

---

## 🤝 Contributing

Contributions, ideas, and suggestions are welcome.

If you would like to improve this project:

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

---

## 📄 License

This project is for learning, portfolio, and demonstration purposes.

---

## 👩‍💻 Author

**Rita**  
Cloud / DevOps Engineer