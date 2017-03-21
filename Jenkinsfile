node {

    stage "build"

    checkout scm

    def version = readFile('test/version').trim()

    def img = docker.build("datagridsys/jenkins-test:${version}", "test")

    stage "publish"

    docker.withRegistry('doker.io', '984001da-18d6-4f15-9a16-bca57f217331') {
        img.push "${version}"
    }


    stage('Deploy') {
        echo "Deploying..."
    }

}

