node {

    stage "build"
    checkout scm
    def version = readFile('test/version').trim()
    def img = docker.build("datagridsys/sample-service:${version}", "sample-service")

    stage "publish"
    docker.withRegistry('https://index.docker.io/v1/', 'sample-docker-registry-id') {
        img.push("${version}")
    }

    stage "deploy"
    // Create an env file that defines the version of the container
    sh "{ echo 'vars:'; echo '  test_ver: $version'; }  > env-build.yaml"

    // Run Skopos CLI
    // Note: the --replace-all forces a re-deploy every time the pipeline runs
    // Remove the flag if that is not desired and Skopos will only deploy if
    // the version of the service changed
    // Note2: Change the address in the -bind parameter to be the address where
    // Skopos can be reached at
    sh "/skopos/bin/sks-ctl run -project ${JOB_NAME} -wait -bind 172.17.0.1:8090 --replace-all -env env.yaml -env env-build.yaml model.yaml"

    // Optionally, run tests against the deployed app
    // stage "test"
    // ...
    // stage "deploy to production"
    // ... same as deploy stage, but call Skopos instance that runs on
    // production cluster
}

