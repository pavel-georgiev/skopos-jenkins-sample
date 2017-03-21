node {

    stage "build"

    checkout scm

    def img = docker.build("datagridsys/jenkins-test", "test")

    stage "publish"

    docker.withRegistry('doker.io', '') {
        img.push
    }


    stage('Deploy') {
        echo "Deploying..."
    }

}

