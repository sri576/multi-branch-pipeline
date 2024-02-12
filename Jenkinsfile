pipeline
{
    agent any
    tools
    {
        maven 'M2_HOME'
    }
    stages
    {
        stage('checkout')
        {
            steps
            {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sri576/java-war-devops.git']])
                sh 'mvn clean install package'
            }
        }
        stage('code quality check')
        {
            steps
            {
               sh ' mvn clean verify sonar:sonar -Dsonar.projectKey=kubernatives -Dsonar.host.url=http://65.2.152.244:9000 -Dsonar.login=sqp_87efc2000d981a0d7326a23eeed324b7774be379' 
               
            }
        }
        stage('Build docker image')
        {
            steps
            {
                script
                {
                    sh 'docker build -t priya576/kubernetes .'
                }
            }
        }
        stage('Push image to hub')
        {
            steps
            {
                script
                {
                    withCredentials([string(credentialsId: 'dockerpwd1', variable: 'dockerpwd1')]) 
                    {
                        sh 'docker login -u priya576 -p ${dockerpwd1}'
                    }
                    sh 'docker push priya576/kubernetes'
                }
            }
        }    
    }
}
