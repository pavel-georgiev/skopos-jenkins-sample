node {

    stage "build"
    checkout scm
    def version = readFile('test/version').trim()
    def img = docker.build("datagridsys/jenkins-test:${version}", "test")


    stage "publish"
    docker.withRegistry('https://index.docker.io/v1/', '984001da-18d6-4f15-9a16-bca57f217331') {
        img.push("${version}")
    }


    stage "deploy"
    // Create an env file that defines the version of the container
    sh "{ echo 'vars:'; echo '  test_ver: $version'; }  > env-build.yaml"

    // Run Skopos CLI
    sh "/skopos/bin/sks-ctl run -project ${JOB_NAME} -wait -bind 172.17.0.1:8090 -env test/env.yaml -env test/env-build.yaml test/model.yaml"

}

