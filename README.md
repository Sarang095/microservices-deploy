# CI/CD Pipeline for Application Stack Deployment on Kubernetes Cluster with AWS

## Overview
This project demonstrates the deployment of a comprehensive application stack, including RabbitMQ, Memcached, MySQL, and a Java-based application on a Tomcat server, to a **Kubernetes cluster** provisioned using **KOPS** on self-created AWS Infrastructure. The CI/CD pipeline leverages **Jenkins** for continuous integration and **ArgoCD** for GitOps-based continuous deployment, ensuring high availability, scalability, and security.

---

## Technologies Used
- **KOPS**: Provisions complete AWS resources(VPC, Subnets, RTs, IGW, EBS Volumes, ELBs, ASGs, IAM roles, Templates and SGs) for launching K8s Cluster.
- **Jenkins**: Continuous Integration for build and testing.
- **ArgoCD**: GitOps-based Continuous Deployment to Kubernetes.
- **SonarQube**: Code quality analysis with Checkstyle, Surefire, and JaCoCo reports.
- **MySQL**: Stateful database with **EBS volumes** for persistent storage.
- **RabbitMQ**: Message queue for asynchronous communication.
- **Memcached**: Caching layer for improved application performance.
- **Tomcat**: Hosting the Java-based application.
- **Amazon EBS**: External storage for Kubernetes StatefulSet.
- **Kubernetes Ingress**: Reverse proxy for routing requests.

---

## Project Workflow
### **Cluster Provisioning**
- Provisioned a **Kubernetes cluster** on **Amazon EC2** using **KOPS**.
- Stored cluster state in an **S3 bucket** for availability and disaster recovery.

### **Service Deployments**
1. **RabbitMQ**  
   - Configured with **ClusterIP Service** and **StatefulSet** for stability.  

2. **Memcached**  
   - Deployed as a **ClusterIP Service** with a **Deployment Spec** for caching.  

3. **MySQL**  
   - Deployed using a **StatefulSet** for maintaining database state.  
   - Leveraged **EBS volumes** for external storage, with **volumeBindingMode: WaitForFirstConsumer** to optimize cost and ensure availability.  

4. **Tomcat Server**  
   - Java application deployed on **Tomcat**, managed by **Kubernetes Deployment**.  
   - Connected to RabbitMQ, Memcached, and MySQL for full stack functionality.  

### **CI/CD Pipeline**
- **Jenkins** for Continuous Integration:
  - Automated build and test process.  
  - Integrated **SonarQube** for:
    - **Checkstyle** reports for code style adherence.
    - **Surefire** for unit test results.
    - **JaCoCo** for code coverage reports.  
- **ArgoCD** for Continuous Deployment:
  - Synchronized application stack deployments from Git repositories.
  - Automated updates for Kubernetes manifests.

---

## Security Enhancements
- **Principle of Least Privilege (PoLP)** enforced at the cluster and container levels to reduce risks.
- Integrated **SonarQube Scanner** to ensure code adheres to quality gates.
- Secured database storage with **EBS volumes** and PVCs for persistence.
