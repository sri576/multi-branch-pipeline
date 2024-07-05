pipeline
{
    agent 'any'
    tools 
    {
        maven 'M2_HOME'
    }
    stages()
    {
        stage('scm')
        {
            steps
            {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sri576/multi-branch-pipeline.git']])
            }
        }
        stage('build')
        {
            steps
            {
                sh 'mvn clean install package'
            }
        }
        stage('code analyzing')
        {
            steps
            {
                sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=multi-branch  -Dsonar.host.url=http://3.108.60.31:9000 -Dsonar.login=sqp_80c590e424098a6b9b949046d9e501c500bdcb8c'
            }
        }
        stage('image')
        {
            steps
            {
                sh 'docker build -t priya576/multi .'
            }
        }
        stage('push image')
        {
            steps
            {
                withCredentials([string(credentialsId: 'Docker-TOKEN', variable: 'srikanth')]) 
                {
                    sh 'docker login -u priya576 -p ${srikanth}'
                }
                sh 'docker push priya576/multi'
            }
        }
    }
}
