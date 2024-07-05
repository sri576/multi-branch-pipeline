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
