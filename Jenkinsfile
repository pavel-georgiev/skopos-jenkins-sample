stage('Build') {
    node {
        checkout scm
        echo "Building..."
        docker.withTool("local") {
            def app = docker.build("datagridsys/jenkins-test", "test")
        }
    }
}


stage('Test') {
    node {
        echo "Testing..."
    }
}


stage('Deploy') {
    node {
        echo "Deploying..."
    }
}
