
pipeline {
    agent any

    stages {
        stage('Deploy To Kubernetes') {
            steps {
                withKubeCredentials(kubectlCredentials: [[
                    caCertificate: '',
                    clusterName: 'sathya.k8s.local',
                    contextName: '',
                    credentialsId: 'k8-token',
                    namespace: 'webapps',
                    serverUrl: 'https://api-sathya-k8s-local-ekmjjp-d3cef3541c534f08.elb.ap-southeast-2.amazonaws.com'
                ]]) {
                    sh 'kubectl apply -f deployment-service.yml'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                withKubeCredentials(kubectlCredentials: [[
                    caCertificate: '',
                    clusterName: 'sathya.k8s.local',
                    contextName: '',
                    credentialsId: 'k8-token',
                    namespace: 'webapps',
                    serverUrl: 'https://api-sathya-k8s-local-ekmjjp-d3cef3541c534f08.elb.ap-southeast-2.amazonaws.com'
                ]]) {
                    sh 'kubectl get deployments -n webapps'
                    sh 'kubectl get pods -n webapps'
                    sh 'kubectl get svc -n webapps'
                }
            }
        }
    }
}

