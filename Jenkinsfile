pipeline {
    agent any

    stages {
        stage('Deploy To Kubernetes') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'sathya.k8s.local', contextName: '', credentialsId: 'k8-token', namespace: 'webapps', serverUrl: '
api-sathya-k8s-local-ekmjjp-d3cef3541c534f08.elb.ap-southeast-2.amazonaws.com']]) {
                    sh "kubectl apply -f deployment-service.yml"
                    
                }
            }
        }
        
        stage('verify Deployment') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'sathya.k8s.local', contextName: '', credentialsId: 'k8-token', namespace: 'webapps', serverUrl: '
api-sathya-k8s-local-ekmjjp-d3cef3541c534f08.elb.ap-southeast-2.amazonaws.com']]) {
                    sh "kubectl get svc -n webapps"
                }
            }
        }
    }
}
