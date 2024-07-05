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
                checkout scmGit(branches: [[name: '*/sri']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sri576/multi-branch-pipeline.git']])
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
                sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=multi-branch1 -Dsonar.host.url=http://3.108.60.31:9000 -Dsonar.login=two'
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
