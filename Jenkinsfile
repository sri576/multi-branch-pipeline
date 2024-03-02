pipeline
{

    agent 'any'
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
            }
        }
        stage('Build')
        {
            steps
            {
                sh 'mvn clean install package'
            }
        }
        stage('code quality check')
        {
            steps
            {
               sh ' mvn clean verify sonar:sonar  -Dsonar.projectKey=java-war-commers  -Dsonar.host.url=http://65.0.72.145:9000 -Dsonar.login=sqp_18b5c879374d5e3f5d6f097a88a3e9eae06ca9a8' 
               
            }
        }
        
        stage('Build docker image')
        {
            steps
            {
                script
                {
                    sh 'docker build -t priya576/kube .'
                }
            }
        }
        
        stage('Push image to hub')
        {
            steps
            {
                script
                {
                    withCredentials([string(credentialsId: 'dockerid', variable: 'srikanth')]) 
                    {
                        sh 'docker login -u priya576 -p ${srikanth}'
                    }
                    sh 'docker push priya576/kube'
                }
            }
        }    
    }
}
